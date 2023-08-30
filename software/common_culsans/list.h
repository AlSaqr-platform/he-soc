/*
 * Minimal Linux-like double-linked list helper functions
 *
 * Copyright (c) 2012-2016, Sven Eckelmann <sven@narfation.org>
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

#pragma once

#ifdef __cplusplus
extern "C" {
#endif

#include <stddef.h>

/**
 * container_of() - Calculate address of object that contains address ptr
 * @ptr: pointer to member variable
 * @type: type of the structure containing ptr
 * @member: name of the member variable in struct @type
 *
 * Return: @type pointer of object containing ptr
 */

#define container_of(ptr, type, member) __extension__ ({ \
	const __typeof__(((type *)0)->member) *__pmember = (ptr); \
	(type *)((char *)__pmember - offsetof(type, member)); })

/**
 * struct list_head - Head and node of a double-linked list
 * @prev: pointer to the previous node in the list
 * @next: pointer to the next node in the list
 *
 * The simple double-linked list consists of a head and nodes attached to
 * this head. Both node and head share the same struct type. The list_*
 * functions and macros can be used to access and modify this data structure.
 *
 * The @prev pointer of the list head points to the last list node of the
 * list and @next points to the first list node of the list. For an empty list,
 * both member variables point to the head.
 *
 * The list nodes are usually embedded in a container structure which holds the
 * actual data. Such an container object is called entry. The helper list_entry
 * can be used to calculate the object address from the address of the node.
 */
struct list_head {
	struct list_head *prev;
	struct list_head *next;
};

/**
 * LIST_HEAD - Declare list head and initialize it
 * @head: name of the new object
 */
#define LIST_HEAD(head) \
	struct list_head head = { &(head), &(head) }

/**
 * INIT_LIST_HEAD() - Initialize empty list head
 * @head: pointer to list head
 *
 * This can also be used to initialize a unlinked list node.
 *
 * A node is usually linked inside a list, will be added to a list in
 * the near future or the entry containing the node will be free'd soon.
 *
 * But an unlinked node may be given to a function which uses list_del(_init)
 * before it ends up in a previously mentioned state. The list_del(_init) on an
 * initialized node is well defined and safe. But the result of a
 * list_del(_init) on an uninitialized node is undefined (unrelated memory is
 * modified, crashes, ...).
 */
static __inline__ void INIT_LIST_HEAD(struct list_head *head)
{
	head->next = head;
	head->prev = head;
}

/**
 * list_add() - Add a list node to the beginning of the list
 * @node: pointer to the new node
 * @head: pointer to the head of the list
 */
static __inline__ void list_add(struct list_head *node,
				struct list_head *head)
{
	struct list_head *next = head->next;

	next->prev = node;
	node->next = next;
	node->prev = head;
	head->next = node;
}

/**
 * list_add_tail() - Add a list node to the end of the list
 * @node: pointer to the new node
 * @head: pointer to the head of the list
 */
static __inline__ void list_add_tail(struct list_head *node,
				     struct list_head *head)
{
	struct list_head *prev = head->prev;

	prev->next = node;
	node->next = head;
	node->prev = prev;
	head->prev = node;
}

/**
 * list_add_before() - Add a list node before another node to the list
 * @new_node: pointer to the new node
 * @node: pointer to the reference node in the list
 *
 * WARNING this functionality is not available in the Linux list implementation
 */
#define list_add_before(new_node, node) \
	list_add_tail(new_node, node)

/**
 * list_add_behind() - Add a list node behind another node to the list
 * @new_node: pointer to the new node
 * @node: pointer to the reference node in the list
 *
 * WARNING this functionality is not available in the Linux list implementation
 */
#define list_add_behind(new_node, node) \
	list_add(new_node, node)

/**
 * list_del() - Remove a list node from the list
 * @node: pointer to the node
 *
 * The node is only removed from the list. Neither the memory of the removed
 * node nor the memory of the entry containing the node is free'd. The node
 * has to be handled like an uninitialized node. Accessing the next or prev
 * pointer of the node is not safe.
 *
 * Unlinked, initialized nodes are also uninitialized after list_del.
 *
 * LIST_POISONING can be enabled during build-time to provoke an invalid memory
 * access when the memory behind the next/prev pointer is used after a list_del.
 * This only works on systems which prohibit access to the predefined memory
 * addresses.
 */
static __inline__ void list_del(struct list_head *node)
{
	struct list_head *next = node->next;
	struct list_head *prev = node->prev;

	next->prev = prev;
	prev->next = next;

#ifdef LIST_POISONING
	node->prev = (struct list_head *)(0x00100100);
	node->next = (struct list_head *)(0x00200200);
#endif
}

/**
 * list_del_init() - Remove a list node from the list and reinitialize it
 * @node: pointer to the node
 *
 * The removed node will not end up in an uninitialized state like when using
 * list_del. Instead the node is initialized again to the unlinked state.
 */
static __inline__ void list_del_init(struct list_head *node)
{
	list_del(node);
	INIT_LIST_HEAD(node);
}

/**
 * list_empty() - Check if list head has no nodes attached
 * @head: pointer to the head of the list
 *
 * Return: 0 - list is not empty !0 - list is empty
 */
static __inline__ int list_empty(const struct list_head *head)
{
	return (head->next == head);
}

/**
 * list_is_singular() - Check if list head has exactly one node attached
 * @head: pointer to the head of the list
 *
 * Return: 0 - list is not singular !0 -list has exactly one entry
 */
static __inline__ int list_is_singular(const struct list_head *head)
{
	return (!list_empty(head) && head->prev == head->next);
}

/**
 * list_splice() - Add list nodes from a list to beginning of another list
 * @list: pointer to the head of the list with the node entries
 * @head: pointer to the head of the list
 *
 * All nodes from @list are added to to the beginning of the list of @head.
 * It is similar to list_add but for multiple nodes. The @list head is not
 * modified and has to be initialized to be used as a valid list head/node
 * again.
 */
static __inline__ void list_splice(struct list_head *list,
				   struct list_head *head)
{
	struct list_head *head_first = head->next;
	struct list_head *list_first = list->next;
	struct list_head *list_last = list->prev;

	if (list_empty(list))
		return;

	head->next = list_first;
	list_first->prev = head;

	list_last->next = head_first;
	head_first->prev = list_last;
}

/**
 * list_splice_tail() - Add list nodes from a list to end of another list
 * @list: pointer to the head of the list with the node entries
 * @head: pointer to the head of the list
 *
 * All nodes from @list are added to to the end of the list of @head.
 * It is similar to list_add_tail but for multiple nodes. The @list head is not
 * modified and has to be initialized to be used as a valid list head/node
 * again.
 */
static __inline__ void list_splice_tail(struct list_head *list,
					struct list_head *head)
{
	struct list_head *head_last = head->prev;
	struct list_head *list_first = list->next;
	struct list_head *list_last = list->prev;

	if (list_empty(list))
		return;

	head->prev = list_last;
	list_last->next = head;

	list_first->prev = head_last;
	head_last->next = list_first;
}

/**
 * list_splice_init() - Move list nodes from a list to beginning of another list
 * @list: pointer to the head of the list with the node entries
 * @head: pointer to the head of the list
 *
 * All nodes from @list are added to to the beginning of the list of @head.
 * It is similar to list_add but for multiple nodes.
 *
 * The @list head will not end up in an uninitialized state like when using
 * list_splice. Instead the @list is initialized again to the an empty
 * list/unlinked state.
 */
static __inline__ void list_splice_init(struct list_head *list,
					struct list_head *head)
{
	list_splice(list, head);
	INIT_LIST_HEAD(list);
}

/**
 * list_splice_tail_init() - Move list nodes from a list to end of another list
 * @list: pointer to the head of the list with the node entries
 * @head: pointer to the head of the list
 *
 * All nodes from @list are added to to the end of the list of @head.
 * It is similar to list_add_tail but for multiple nodes.
 *
 * The @list head will not end up in an uninitialized state like when using
 * list_splice. Instead the @list is initialized again to the an empty
 * list/unlinked state.
 */
static __inline__ void list_splice_tail_init(struct list_head *list,
					     struct list_head *head)
{
	list_splice_tail(list, head);
	INIT_LIST_HEAD(list);
}

/**
 * list_cut_position() - Move beginning of a list to another list
 * @head_to: pointer to the head of the list which receives nodes
 * @head_from: pointer to the head of the list
 * @node: pointer to the node in which defines the cutting point
 *
 * All entries from the beginning of the list @head_from to (including) the
 * @node is moved to @head_from.
 *
 * @head_to is replaced when @head_from is not empty. @node must be a real
 * list node from @head_from or the behavior is undefined.
 */
static __inline__ void list_cut_position(struct list_head *head_to,
					 struct list_head *head_from,
					 struct list_head *node)
{
	struct list_head *head_from_first = head_from->next;

	if (list_empty(head_from))
		return;

	if (head_from == node) {
		INIT_LIST_HEAD(head_to);
		return;
	}

	head_from->next = node->next;
	head_from->next->prev = head_from;

	head_to->prev = node;
	node->next = head_to;
	head_to->next = head_from_first;
	head_to->next->prev = head_to;
}

/**
 * list_move() - Move a list node to the beginning of the list
 * @node: pointer to the node
 * @head: pointer to the head of the list
 *
 * The @node is removed from its old position/node and add to the beginning of
 * @head
 */
static __inline__ void list_move(struct list_head *node, struct list_head *head)
{
	list_del(node);
	list_add(node, head);
}

/**
 * list_move_tail() - Move a list node to the end of the list
 * @node: pointer to the node
 * @head: pointer to the head of the list
 *
 * The @node is removed from its old position/node and add to the end of @head
 */
static __inline__ void list_move_tail(struct list_head *node,
				      struct list_head *head)
{
	list_del(node);
	list_add_tail(node, head);
}

/**
 * list_entry() - Calculate address of entry that contains list node
 * @node: pointer to list node
 * @type: type of the entry containing the list node
 * @member: name of the list_head member variable in struct @type
 *
 * Return: @type pointer of entry containing node
 */
#define list_entry(node, type, member) container_of(node, type, member)

/**
 * list_first_entry() - get first entry of the list
 * @head: pointer to the head of the list
 * @type: type of the entry containing the list node
 * @member: name of the list_head member variable in struct @type
 *
 * Return: @type pointer of first entry in list
 */
#define list_first_entry(head, type, member) \
	list_entry((head)->next, type, member)

/**
 * list_last_entry() - get last entry of the list
 * @head: pointer to the head of the list
 * @type: type of the entry containing the list node
 * @member: name of the list_head member variable in struct @type
 *
 * Return: @type pointer of last entry in list
 */
#define list_last_entry(head, type, member) \
	list_entry((head)->prev, type, member)

/**
 * list_for_each - iterate over list nodes
 * @node: list_head pointer used as iterator
 * @head: pointer to the head of the list
 *
 * The nodes and the head of the list must must be kept unmodified while
 * iterating through it. Any modifications to the the list will cause undefined
 * behavior.
 */
#define list_for_each(node, head) \
	for (node = (head)->next; \
	     node != (head); \
	     node = node->next)

/**
 * list_for_each_entry_t - iterate over list entries
 * @entry: @type pointer used as iterator
 * @head: pointer to the head of the list
 * @type: type of the entries containing the list nodes
 * @member: name of the list_head member variable in struct @type
 *
 * The nodes and the head of the list must must be kept unmodified while
 * iterating through it. Any modifications to the the list will cause undefined
 * behavior.
 *
 * WARNING this functionality is not available in the Linux list implementation
 */
#define list_for_each_entry_t(entry, head, type, member) \
	for (entry = list_entry((head)->next, type, member); \
	     &entry->member != (head); \
	     entry = list_entry(entry->member.next, type, member))

/**
 * list_for_each_entry - iterate over list entries
 * @entry: pointer used as iterator
 * @head: pointer to the head of the list
 * @member: name of the list_head member variable in struct type of @entry
 *
 * The nodes and the head of the list must must be kept unmodified while
 * iterating through it. Any modifications to the the list will cause undefined
 * behavior.
 */
#define list_for_each_entry(entry, head, member) \
	list_for_each_entry_t(entry, head, __typeof__(*entry), member)

/**
 * list_for_each_safe - iterate over list nodes and allow deletes
 * @node: list_head pointer used as iterator
 * @safe: list_head pointer used to store info for next entry in list
 * @head: pointer to the head of the list
 *
 * The current node (iterator) is allowed to be removed from the list. Any
 * other modifications to the the list will cause undefined behavior.
 */
#define list_for_each_safe(node, safe, head) \
	for (node = (head)->next, safe = node->next; \
	     node != (head); \
	     node = safe, safe = node->next)

/**
 * list_for_each_entry_safe_t - iterate over list entries and allow deletes
 * @entry: @type pointer used as iterator
 * @safe: @type pointer used to store info for next entry in list
 * @head: pointer to the head of the list
 * @type: type of the entries containing the list nodes
 * @member: name of the list_head member variable in struct @type
 *
 * The current node (iterator) is allowed to be removed from the list. Any
 * other modifications to the the list will cause undefined behavior.
 *
 * WARNING this functionality is not available in the Linux list implementation
 */
#define list_for_each_entry_safe_t(entry, safe, head, type, member) \
	for (entry = list_entry((head)->next, type, member), \
	     safe = list_entry(entry->member.next, type, member); \
	     &entry->member != (head); \
	     entry = safe, \
	     safe = list_entry(safe->member.next, type, member))

/**
 * list_for_each_entry_safe - iterate over list entries and allow deletes
 * @entry: pointer used as iterator
 * @safe: @type pointer used to store info for next entry in list
 * @head: pointer to the head of the list
 * @member: name of the list_head member variable in struct type of @entry
 *
 * The current node (iterator) is allowed to be removed from the list. Any
 * other modifications to the the list will cause undefined behavior.
 */
#define list_for_each_entry_safe(entry, safe, head, member) \
	list_for_each_entry_safe_t(entry, safe, head, __typeof__(*entry), \
				   member)

#ifdef __cplusplus
}
#endif

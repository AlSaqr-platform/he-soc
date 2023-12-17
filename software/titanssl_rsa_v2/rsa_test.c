#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>

// Funzione di calcolo del massimo comun divisore
unsigned long long gcd(unsigned long long a, unsigned long long b) {
    if (b == 0) return a;
    return gcd(b, a % b);
}

// Funzione di calcolo del minimo comune multiplo
unsigned long long lcm(unsigned long long a, unsigned long long b) {
    return (a / gcd(a, b)) * b;
}

// Funzione di esponenziazione modulare
unsigned long long mod_exp(unsigned long long base, unsigned long long exponent, unsigned long long mod) {
    unsigned long long result = 1;
    base = base % mod;
    while (exponent > 0) {
        if (exponent % 2 == 1) {
            result = (result * base) % mod;
        }
        exponent = exponent >> 1;
        base = (base * base) % mod;
    }
    return result;
}

// Funzione per generare le chiavi RSA
void generate_keys(unsigned long long *public_key, unsigned long long *private_key, unsigned long long *modulus) {
    unsigned long long p = 61;  // Scelta arbitraria di due numeri primi per p e q
    unsigned long long q = 53;
    
    *modulus = p * q;
    unsigned long long phi = lcm(p - 1, q - 1);

    // Trova un esponente pubblico (e) che sia coprimo con phi
    unsigned long long e = 17;  // Scelta arbitraria di un esponente pubblico
    while (gcd(e, phi) != 1) {
        e++;
    }

    *public_key = e;

    // Trova l'esponente privato (d) che soddisfi (d * e) % phi = 1
    unsigned long long d = 1;
    while ((d * e) % phi != 1) {
        d++;
    }

    *private_key = d;
}

// Funzione di encryption RSA
void rsa_encrypt(const char *plaintext, uint64_t *ciphertext, unsigned long long public_key, unsigned long long modulus, size_t length) {
    for (size_t i = 0; i < length; i++) {
        ciphertext[i] = mod_exp(plaintext[i], public_key, modulus);
    }
}

// Funzione di decryption RSA
void rsa_decrypt(const uint64_t *ciphertext, char *decrypted, unsigned long long private_key, unsigned long long modulus, size_t length) {
    for (size_t i = 0; i < length; i++) {
        decrypted[i] = (char)mod_exp(ciphertext[i], private_key, modulus) & 0xFF;
    }
}


int main() {
    const char *plaintext = "Hello RSA!";
    size_t length = strlen(plaintext);

    unsigned long long public_key, private_key, modulus;
    generate_keys(&public_key, &private_key, &modulus);

    uint64_t ciphertext[length];
    rsa_encrypt(plaintext, ciphertext, public_key, modulus, length);

    char decrypted[length];
    rsa_decrypt(ciphertext, decrypted, private_key, modulus, length);

    printf("Plaintext: %s\n", plaintext);
    printf("Ciphertext: ");
    for (size_t i = 0; i < length; i++) {
        printf("%llx ", ciphertext[i]);
    }
    printf("\n");

    printf("Decrypted: %s\n", decrypted);

    return 0;
}


// ----------------------------------

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_DIGITS 1000

typedef struct {
    int digits[MAX_DIGITS];
    int length;
} bigint;

void init_bigint(bigint *num, const char *str) {
    int i, j;
    int len = strlen(str);

    for (i = 0, j = len - 1; i < len; i++, j--) {
        num->digits[i] = str[j] - '0';
    }

    num->length = len;
}

void print_bigint(const bigint *num) {
    int i;

    for (i = num->length - 1; i >= 0; i--) {
        printf("%d", num->digits[i]);
    }

    printf("\n");
}

void add_bigint(const bigint *num1, const bigint *num2, bigint *result) {
    int carry = 0;
    int i, sum;

    for (i = 0; i < num1->length || i < num2->length; i++) {
        sum = carry + num1->digits[i] + num2->digits[i];
        result->digits[i] = sum % 10;
        carry = sum / 10;
    }

    if (carry > 0) {
        result->digits[i] = carry;
        result->length = i + 1;
    } else {
        result->length = i;
    }
}

void multiply_bigint(const bigint *num1, const bigint *num2, bigint *result) {
    int i, j, product, carry;

    for (i = 0; i < num1->length; i++) {
        carry = 0;

        for (j = 0; j < num2->length || carry > 0; j++) {
            product = result->digits[i + j] + num1->digits[i] * (j < num2->length ? num2->digits[j] : 0) + carry;
            result->digits[i + j] = product % 10;
            carry = product / 10;
        }
    }

    result->length = i + j - 1;
}

int compare_bigint(const bigint *num1, const bigint *num2) {
    if (num1->length > num2->length) return 1;
    if (num1->length < num2->length) return -1;

    for (int i = num1->length - 1; i >= 0; i--) {
        if (num1->digits[i] > num2->digits[i]) return 1;
        if (num1->digits[i] < num2->digits[i]) return -1;
    }

    return 0;
}

void subtract_bigint(const bigint *num1, const bigint *num2, bigint *result) {
    int borrow = 0;

    for (int i = 0; i < num1->length; i++) {
        int diff = num1->digits[i] - borrow - (i < num2->length ? num2->digits[i] : 0);

        if (diff < 0) {
            diff += 10;
            borrow = 1;
        } else {
            borrow = 0;
        }

        result->digits[i] = diff;
    }

    result->length = num1->length;

    while (result->length > 1 && result->digits[result->length - 1] == 0) {
        result->length--;
    }
}

//
void divide_bigint(const bigint *num1, const bigint *num2, bigint *quotient, bigint *remainder) {
    bigint temp, current;
    init_bigint(remainder, "0");

    for (int i = num1->length - 1; i >= 0; i--) {
        multiply_bigint(remainder, num2, &temp);
        current.digits[0] = num1->digits[i];
        current.length = 1;

        add_bigint(&temp, &current, remainder);

        int x = 0;

        while (compare_bigint(remainder, num2) >= 0) {
            subtract_bigint(remainder, num2, remainder);
            x++;
        }

        quotient->digits[i] = x;
    }

    quotient->length = num1->length;

    while (quotient->length > 1 && quotient->digits[quotient->length - 1] == 0) {
        quotient->length--;
    }
}

void modulo_bigint(const bigint *num1, const bigint *num2, bigint *result) {
    bigint quotient, temp;
    divide_bigint(num1, num2, &quotient, &temp);
    multiply_bigint(&quotient, num2, &temp);
    subtract_bigint(num1, &temp, result);
}

void uint8_array_to_bigint(const uint8_t *array, int array_length, bigint *result) {
    int i, j;

    // Inizializza a zero il bigint di destinazione
    for (i = 0; i < MAX_DIGITS; i++) {
        result->digits[i] = 0;
    }

    // Copia i dati dall'array di uint8_t al bigint
    for (i = 0, j = array_length - 1; i < array_length && i < MAX_DIGITS; i++, j--) {
        result->digits[i] = array[j];
    }

    // Imposta la lunghezza del bigint in base ai dati copiati
    result->length = i;
}

// Funzione di calcolo del massimo comun divisore
unsigned long long gcd(unsigned long long a, unsigned long long b) {
    if (b == 0) return a;
    return gcd(b, a % b);
}

// Funzione di calcolo del minimo comune multiplo
unsigned long long lcm(unsigned long long a, unsigned long long b) {
    return (a / gcd(a, b)) * b;
}

// Funzione di esponenziazione modulare
private_key mod_exp(unsigned long long base, bigint exponent, bigint mod) {
    bigint result, temp, _remainder;
    init_bigint(&result, "1");
    init_bigint(&temp, base);
    modulo_bigint(&base, &mod, &_remainder);
    base = _remainder;
    while (exponent > 0) {
        if (exponent % 2 == 1) {
            result = (result * base) % mod;
        }
        exponent = exponent >> 1;
        base = (base * base) % mod;
    }
    return result;
}

// Funzione di encryption RSA
void rsa_encrypt(const char *plaintext, uint64_t *ciphertext, bigint public_key, bigint modulus, size_t length) {
    for (size_t i = 0; i < length; i++) {
        ciphertext[i] = mod_exp(plaintext[i], public_key, modulus);
    }
}

// Funzione di decryption RSA
void rsa_decrypt(const uint64_t *ciphertext, char *decrypted, bigint private_key, bigint modulus, size_t length) {
    for (size_t i = 0; i < length; i++) {
        decrypted[i] = (char)mod_exp(ciphertext[i], private_key, modulus) & 0xFF;
    }
}



int main() {
    uint8_t _in[] = {0x48, 0x65, 0x6c, 0x6c, 0x6f, 0x2c, 0x20, 0x52, 0x53, 0x41, 0x21};
    uint8_t _puk[] = {0x01, 0x00, 0x01};
    uint8_t _mod[] = {0xa8, 0x57, 0x35, 0xed, 0x0a, 0x2b, 0xe4, 0x82, 0x14, 0xf3, 0x6f, 0x44, 0xee, 0x8a, 0xfd, 0x52, 0x12, 0x20, 0x84, 0x75, 0x9a, 0x65, 0x19, 0x38, 0xeb, 0xc7, 0x9c, 0xa5, 0x87, 0x0f, 0x29, 0xe3, 0x88, 0x49, 0x55, 0x87, 0x3d, 0x9d, 0xe5, 0xd3, 0xa6, 0xf2, 0x00, 0x54, 0xeb, 0xd2, 0xe2, 0x30, 0x96, 0x47, 0x68, 0x44, 0xe7, 0x38, 0xf3, 0xfd, 0xc6, 0x6f, 0x44, 0xa2, 0x0a, 0xb5, 0xee, 0xaf, 0xee, 0xcb, 0x43, 0x32, 0xfd, 0xef, 0x06, 0xfd, 0x2e, 0xc1, 0x7b, 0xb0, 0x31, 0x6e, 0x85, 0xc8, 0x8d, 0xdb, 0x27, 0xf6, 0x5b, 0x2a, 0x76, 0x49, 0x62, 0x12, 0x73, 0xd6, 0x4f, 0x4a, 0x09, 0xec, 0x62, 0xf9, 0x3e, 0x2c, 0xbb, 0xa8, 0x3f, 0x64, 0x2f, 0xa0, 0x8d, 0x1d, 0x5f, 0x18, 0x6f, 0x76, 0xe7, 0xd5, 0x8f, 0x75, 0x45, 0x7e, 0x03, 0xd8, 0x25, 0x9d, 0x1b, 0x11, 0x40, 0x3f, 0xa6, 0x8b};
    uint8_t  _prk[] = {0x2b, 0x56, 0x88, 0x63, 0x86, 0x02, 0xd6, 0xc9, 0x46, 0x6b, 0x85, 0x71, 0xd1, 0x97, 0xa6, 0xaf, 0xc2, 0x4a, 0xec, 0xce, 0xf9, 0xf8, 0x9d, 0x0d, 0xb2, 0x65, 0xa9, 0x46, 0x54, 0x06, 0xeb, 0x59, 0xd0, 0x74, 0x50, 0xb8, 0x88, 0x7c, 0x65, 0xf6, 0x9f, 0x3c, 0x1e, 0x29, 0xbe, 0xac, 0x83, 0xde, 0xce, 0x51, 0x83, 0xde, 0x79, 0x48, 0x88, 0x48, 0x05, 0x16, 0x10, 0x2d, 0x47, 0x64, 0x9f, 0x15, 0xf1, 0x17, 0x96, 0xc7, 0x8c, 0xdb, 0x6f, 0x8b, 0x8b, 0x73, 0x70, 0x4a, 0x89, 0x28, 0x18, 0x73, 0x6c, 0x30, 0xb2, 0xec, 0xfc, 0xc8, 0x21, 0x59, 0x2e, 0x08, 0x91, 0x0e, 0x7e, 0x63, 0x5b, 0xf5, 0x97, 0x01, 0xa6, 0x3b, 0xff, 0x85, 0xe0, 0x61, 0xcc, 0x6f, 0x0d, 0x65, 0x79, 0x83, 0x41, 0x60, 0xa8, 0x61, 0x27, 0x2f, 0x62, 0x77, 0xe1, 0xf0, 0x76, 0xf1, 0x3a, 0x0f, 0xe0, 0x82, 0xe6, 0x01};
    uint8_t _out[] = {0x67, 0x15, 0x02, 0x28, 0x42, 0x60, 0xd1, 0xa1, 0xfb, 0x6f, 0xec, 0x79, 0x38, 0x7b, 0x0e, 0xd4, 0x9d, 0x04, 0x30, 0x45, 0xc3, 0xa2, 0x31, 0x89, 0xed, 0x8d, 0x77, 0xf4, 0x93, 0x95, 0x7b, 0x95, 0xa7, 0xe4, 0x82, 0x79, 0x3d, 0x17, 0xba, 0x8f, 0x41, 0x47, 0x30, 0x5b, 0xcd, 0x84, 0x0d, 0xfb, 0xd3, 0x76, 0x55, 0x2f, 0xc1, 0x0e, 0x4f, 0x71, 0x81, 0xa6, 0xcf, 0x75, 0xf2, 0x79, 0x89, 0xec, 0x48, 0x85, 0xe4, 0x33, 0x1f, 0x2e, 0x24, 0xfe, 0xdd, 0xfa, 0x79, 0x77, 0x21, 0x3a, 0x6b, 0xb9, 0x16, 0x0d, 0xa9, 0x39, 0x09, 0x9a, 0xee, 0x75, 0xba, 0x97, 0x41, 0x4a, 0x4f, 0xe0, 0xa7, 0x34, 0x6c, 0x5d, 0xf5, 0x83, 0xaf, 0x11, 0x55, 0xea, 0x65, 0x10, 0xe8, 0x22, 0x09, 0xe2, 0xad, 0x16, 0xbb, 0xfa, 0x7f, 0x98, 0x05, 0x98, 0x59, 0x1b, 0xe7, 0x48, 0x9b, 0x42, 0xb5, 0x0a, 0x59, 0xcc};
   
    
    bigint moduls, pub_exponent, priv_exponent;

    uint8_array_to_bigint(_mod, sizeof(_mod) / sizeof(_mod[0]), &modulus);
    uint8_array_to_bigint(_prk, sizeof(_prk) / sizeof(_prk[0]), &private_key)
    uint8_array_to_bigint(_mod, sizeof(_puk) / sizeof(_puk[0]), &public_key)

    uint64_t ciphertext[length];
    rsa_encrypt(plaintext, ciphertext, public_key, modulus, length);

    char decrypted[length];
    rsa_decrypt(ciphertext, decrypted, private_key, modulus, length);

    printf("Plaintext: %s\n", plaintext);
    printf("Ciphertext: ");
    for (size_t i = 0; i < length; i++) {
        printf("%llx ", ciphertext[i]);
    }
    printf("\n");

    printf("Decrypted: %s\n", decrypted);

    return 0;
}

int main() {
    bigint num1, num2, sum, diffe, product, quotient, _remainder;

    // init_bigint(&num1, "123456789012345678901234567890");
    // init_bigint(&num2, "987654321098765432109876543210");
    
    init_bigint(&num1, "12123456789");
    init_bigint(&num2, "12123456789");

    // Addizione
    add_bigint(&num1, &num2, &sum);
    printf("Sum: ");
    print_bigint(&sum);

    // Moltiplicazione
    multiply_bigint(&num1, &num2, &product);
    printf("Product: ");
    print_bigint(&product);
    
    // Sottrazione
    subtract_bigint(&num1, &num2, &diffe);
    printf("Diference: ");
    print_bigint(&diffe);
    

    divide_bigint(&num1, &num2, &quotient, &_remainder);
    printf("Quotient: ");
    print_bigint(&quotient);
    printf("Remainder: ");
    print_bigint(&_remainder);

    // Modulo
    // modulo_bigint(&num1, &num2, &_remainder);
    printf("Modulo: ");
    print_bigint(&_remainder);

    return 0;
}
PROJECT:=axi_dma_0

all:
	mkdir -p ip
	vitis-2020.2 vivado -mode batch -source run.tcl
	cp -r ${PROJECT}.srcs/sources_1/ip/${PROJECT}/* ip/.
	cp ${PROJECT}.runs/${PROJECT}_synth_1/${PROJECT}.dcp ip/.

gui:
	vivado-2018.2 vivado -mode gui -source run.tcl &

clean:
	rm -rf ip
	rm -rf ${PROJECT}.*
	rm -rf component.xml
	rm -rf vivado*.jou
	rm -rf vivado*.log
	rm -rf vivado*.str
	rm -rf xgui
	rm -rf .Xil

# File saved with Nlview 7.8.0 2024-04-26 e1825d835c VDI=44 GEI=38 GUI=JA:21.0 threadsafe
# 
# non-default properties - (restore without -noprops)
property -colorscheme classic
property attrcolor #000000
property attrfontsize 8
property autobundle 1
property backgroundcolor #ffffff
property boxcolor0 #000000
property boxcolor1 #000000
property boxcolor2 #000000
property boxinstcolor #000000
property boxpincolor #000000
property buscolor #008000
property closeenough 5
property createnetattrdsp 2048
property decorate 1
property elidetext 40
property fillcolor1 #ffffcc
property fillcolor2 #dfebf8
property fillcolor3 #f0f0f0
property gatecellname 2
property instattrmax 30
property instdrag 15
property instorder 1
property marksize 12
property maxfontsize 12
property maxzoom 5
property netcolor #19b400
property objecthighlight0 #ff00ff
property objecthighlight1 #ffff00
property objecthighlight2 #00ff00
property objecthighlight3 #0095ff
property objecthighlight4 #8000ff
property objecthighlight5 #ffc800
property objecthighlight7 #00ffff
property objecthighlight8 #ff00ff
property objecthighlight9 #ccccff
property objecthighlight10 #0ead00
property objecthighlight11 #cefc00
property objecthighlight12 #9e2dbe
property objecthighlight13 #ba6a29
property objecthighlight14 #fc0188
property objecthighlight15 #02f990
property objecthighlight16 #f1b0fb
property objecthighlight17 #fec004
property objecthighlight18 #149bff
property objecthighlight19 #0000ff
property overlaycolor #19b400
property pbuscolor #000000
property pbusnamecolor #000000
property pinattrmax 20
property pinorder 2
property pinpermute 0
property portcolor #000000
property portnamecolor #000000
property ripindexfontsize 4
property rippercolor #000000
property rubberbandcolor #000000
property rubberbandfontsize 12
property selectattr 0
property selectionappearance 2
property selectioncolor #0000ff
property sheetheight 44
property sheetwidth 68
property showmarks 1
property shownetname 0
property showpagenumbers 1
property showripindex 1
property timelimit 1
#
module new mbv_system_wrapper work:mbv_system_wrapper:NOFILE -nosplit
load symbol IOBUF {hdi_primitives:netlist:no file specified} HIERBOX pin IO inout.right pin O output.right pin I input.left pin T input.left fillcolor 2
load symbol IOBUF {hdi_primitives:abstract:no file specified} HIERBOX pin IO inout.right pin O output.right pin I input.left pin T input.left fillcolor 2
load symbol mbv_system work:mbv_system:NOFILE HIERBOX pin eth_mdio_mdc_mdc output.right pin eth_mdio_mdc_mdio_i input.left pin eth_mdio_mdc_mdio_o output.right pin eth_mdio_mdc_mdio_t output.right pin eth_mii_col input.left pin eth_mii_crs input.left pin eth_mii_rst_n output.right pin eth_mii_rx_clk input.left pin eth_mii_rx_dv input.left pin eth_mii_rx_er input.left pin eth_mii_tx_clk input.left pin eth_mii_tx_en output.right pin i2c_scl_i input.left pin i2c_scl_o output.right pin i2c_scl_t output.right pin i2c_sda_i input.left pin i2c_sda_o output.right pin i2c_sda_t output.right pin qspi_flash_io0_i input.left pin qspi_flash_io0_o output.right pin qspi_flash_io0_t output.right pin qspi_flash_io1_i input.left pin qspi_flash_io1_o output.right pin qspi_flash_io1_t output.right pin qspi_flash_io2_i input.left pin qspi_flash_io2_o output.right pin qspi_flash_io2_t output.right pin qspi_flash_io3_i input.left pin qspi_flash_io3_o output.right pin qspi_flash_io3_t output.right pin qspi_flash_sck_i input.left pin qspi_flash_sck_o output.right pin qspi_flash_sck_t output.right pin qspi_flash_ss_i input.left pin qspi_flash_ss_o output.right pin qspi_flash_ss_t output.right pin reset input.left pin spi_io0_i input.left pin spi_io0_o output.right pin spi_io0_t output.right pin spi_io1_i input.left pin spi_io1_o output.right pin spi_io1_t output.right pin spi_sck_i input.left pin spi_sck_o output.right pin spi_sck_t output.right pin spi_ss_i input.left pin spi_ss_o output.right pin spi_ss_t output.right pin sys_clock input.left pin usb_uart_rxd input.left pin usb_uart_txd output.right pinBus dip_switches_4bits_tri_i input.left [3:0] pinBus eth_mii_rxd input.left [3:0] pinBus eth_mii_txd output.right [3:0] pinBus i2c_pullups_tri_o output.right [1:0] pinBus led_4bits_tri_o output.right [3:0] pinBus push_buttons_4bits_tri_i input.left [3:0] pinBus rgb_led_tri_o output.right [11:0] pinBus shield_dp0_dp19_tri_i input.left [19:0] pinBus shield_dp0_dp19_tri_o output.right [19:0] pinBus shield_dp0_dp19_tri_t output.right [19:0] pinBus shield_dp26_dp41_tri_i input.left [15:0] pinBus shield_dp26_dp41_tri_o output.right [15:0] pinBus shield_dp26_dp41_tri_t output.right [15:0] boxcolor 1 fillcolor 2 minwidth 13%
load port eth_mdio_mdc_mdc output -pg 1 -lvl 3 -x 1740 -y 2870
load port eth_mdio_mdc_mdio_io inout -pg 1 -lvl 3 -x 1740 -y 3810
load port eth_mii_col input -pg 1 -lvl 0 -x 0 -y 3010
load port eth_mii_crs input -pg 1 -lvl 0 -x 0 -y 3030
load port eth_mii_rst_n output -pg 1 -lvl 3 -x 1740 -y 2930
load port eth_mii_rx_clk input -pg 1 -lvl 0 -x 0 -y 3050
load port eth_mii_rx_dv input -pg 1 -lvl 0 -x 0 -y 3070
load port eth_mii_rx_er input -pg 1 -lvl 0 -x 0 -y 3090
load port eth_mii_tx_clk input -pg 1 -lvl 0 -x 0 -y 3130
load port eth_mii_tx_en output -pg 1 -lvl 3 -x 1740 -y 2950
load port i2c_scl_io inout -pg 1 -lvl 3 -x 1740 -y 3910
load port i2c_sda_io inout -pg 1 -lvl 3 -x 1740 -y 4210
load port qspi_flash_io0_io inout -pg 1 -lvl 3 -x 1740 -y 2260
load port qspi_flash_io1_io inout -pg 1 -lvl 3 -x 1740 -y 2380
load port qspi_flash_io2_io inout -pg 1 -lvl 3 -x 1740 -y 2500
load port qspi_flash_io3_io inout -pg 1 -lvl 3 -x 1740 -y 2610
load port qspi_flash_sck_io inout -pg 1 -lvl 3 -x 1740 -y 2770
load port qspi_flash_ss_io inout -pg 1 -lvl 3 -x 1740 -y 4070
load port reset input -pg 1 -lvl 0 -x 0 -y 3330
load port spi_io0_io inout -pg 1 -lvl 3 -x 1740 -y 3710
load port spi_io1_io inout -pg 1 -lvl 3 -x 1740 -y 3770
load port spi_sck_io inout -pg 1 -lvl 3 -x 1740 -y 4370
load port spi_ss_io inout -pg 1 -lvl 3 -x 1740 -y 4550
load port sys_clock input -pg 1 -lvl 0 -x 0 -y 3370
load port usb_uart_rxd input -pg 1 -lvl 0 -x 0 -y 3550
load port usb_uart_txd output -pg 1 -lvl 3 -x 1740 -y 3610
load portBus dip_switches_4bits_tri_i input [3:0] -attr @name dip_switches_4bits_tri_i[3:0] -pg 1 -lvl 0 -x 0 -y 2970
load portBus eth_mii_rxd input [3:0] -attr @name eth_mii_rxd[3:0] -pg 1 -lvl 0 -x 0 -y 3110
load portBus eth_mii_txd output [3:0] -attr @name eth_mii_txd[3:0] -pg 1 -lvl 3 -x 1740 -y 2970
load portBus i2c_pullups_tri_o output [1:0] -attr @name i2c_pullups_tri_o[1:0] -pg 1 -lvl 3 -x 1740 -y 2990
load portBus led_4bits_tri_o output [3:0] -attr @name led_4bits_tri_o[3:0] -pg 1 -lvl 3 -x 1740 -y 3090
load portBus push_buttons_4bits_tri_i input [3:0] -attr @name push_buttons_4bits_tri_i[3:0] -pg 1 -lvl 0 -x 0 -y 3190
load portBus rgb_led_tri_o output [11:0] -attr @name rgb_led_tri_o[11:0] -pg 1 -lvl 3 -x 1740 -y 3350
load portBus shield_dp0_dp19_tri_io inout [19:0] -attr @name shield_dp0_dp19_tri_io[19:0] -pg 1 -lvl 3 -x 1740 -y 60
load portBus shield_dp26_dp41_tri_io inout [15:0] -attr @name shield_dp26_dp41_tri_io[15:0] -pg 1 -lvl 3 -x 1740 -y 4670
load inst eth_mdio_mdc_mdio_iobuf IOBUF {hdi_primitives:netlist:no file specified} -autohide -attr @cell(#000000) IOBUF -pg 1 -lvl 1 -x 280 -y 3760
load inst i2c_scl_iobuf IOBUF {hdi_primitives:abstract:no file specified} -autohide -attr @cell(#000000) IOBUF -pg 1 -lvl 1 -x 280 -y 3900
load inst i2c_sda_iobuf IOBUF {hdi_primitives:abstract:no file specified} -autohide -attr @cell(#000000) IOBUF -pg 1 -lvl 1 -x 280 -y 4200
load inst mbv_system_i mbv_system work:mbv_system:NOFILE -autohide -attr @cell(#000000) mbv_system -pinBusAttr dip_switches_4bits_tri_i @name dip_switches_4bits_tri_i[3:0] -pinBusAttr eth_mii_rxd @name eth_mii_rxd[3:0] -pinBusAttr eth_mii_txd @name eth_mii_txd[3:0] -pinBusAttr i2c_pullups_tri_o @name i2c_pullups_tri_o[1:0] -pinBusAttr led_4bits_tri_o @name led_4bits_tri_o[3:0] -pinBusAttr push_buttons_4bits_tri_i @name push_buttons_4bits_tri_i[3:0] -pinBusAttr rgb_led_tri_o @name rgb_led_tri_o[11:0] -pinBusAttr shield_dp0_dp19_tri_i @name shield_dp0_dp19_tri_i[19:0] -pinBusAttr shield_dp0_dp19_tri_o @name shield_dp0_dp19_tri_o[19:0] -pinBusAttr shield_dp0_dp19_tri_t @name shield_dp0_dp19_tri_t[19:0] -pinBusAttr shield_dp26_dp41_tri_i @name shield_dp26_dp41_tri_i[15:0] -pinBusAttr shield_dp26_dp41_tri_o @name shield_dp26_dp41_tri_o[15:0] -pinBusAttr shield_dp26_dp41_tri_t @name shield_dp26_dp41_tri_t[15:0] -pg 1 -lvl 2 -x 1010 -y 2860
load inst qspi_flash_io0_iobuf IOBUF {hdi_primitives:abstract:no file specified} -autohide -attr @cell(#000000) IOBUF -pg 1 -lvl 1 -x 280 -y 2250
load inst qspi_flash_io1_iobuf IOBUF {hdi_primitives:abstract:no file specified} -autohide -attr @cell(#000000) IOBUF -pg 1 -lvl 1 -x 280 -y 2370
load inst qspi_flash_io2_iobuf IOBUF {hdi_primitives:abstract:no file specified} -autohide -attr @cell(#000000) IOBUF -pg 1 -lvl 1 -x 280 -y 2490
load inst qspi_flash_io3_iobuf IOBUF {hdi_primitives:abstract:no file specified} -autohide -attr @cell(#000000) IOBUF -pg 1 -lvl 1 -x 280 -y 2600
load inst qspi_flash_sck_iobuf IOBUF {hdi_primitives:abstract:no file specified} -autohide -attr @cell(#000000) IOBUF -pg 1 -lvl 1 -x 280 -y 2800
load inst qspi_flash_ss_iobuf IOBUF {hdi_primitives:abstract:no file specified} -autohide -attr @cell(#000000) IOBUF -pg 1 -lvl 1 -x 280 -y 4060
load inst shield_dp0_dp19_tri_iobuf_0 IOBUF {hdi_primitives:abstract:no file specified} -autohide -attr @cell(#000000) IOBUF -pg 1 -lvl 1 -x 280 -y 50
load inst shield_dp0_dp19_tri_iobuf_1 IOBUF {hdi_primitives:abstract:no file specified} -autohide -attr @cell(#000000) IOBUF -pg 1 -lvl 1 -x 280 -y 160
load inst shield_dp0_dp19_tri_iobuf_10 IOBUF {hdi_primitives:abstract:no file specified} -autohide -attr @cell(#000000) IOBUF -pg 1 -lvl 1 -x 280 -y 1150
load inst shield_dp0_dp19_tri_iobuf_11 IOBUF {hdi_primitives:abstract:no file specified} -autohide -attr @cell(#000000) IOBUF -pg 1 -lvl 1 -x 280 -y 1260
load inst shield_dp0_dp19_tri_iobuf_12 IOBUF {hdi_primitives:abstract:no file specified} -autohide -attr @cell(#000000) IOBUF -pg 1 -lvl 1 -x 280 -y 1370
load inst shield_dp0_dp19_tri_iobuf_13 IOBUF {hdi_primitives:abstract:no file specified} -autohide -attr @cell(#000000) IOBUF -pg 1 -lvl 1 -x 280 -y 1480
load inst shield_dp0_dp19_tri_iobuf_14 IOBUF {hdi_primitives:abstract:no file specified} -autohide -attr @cell(#000000) IOBUF -pg 1 -lvl 1 -x 280 -y 1590
load inst shield_dp0_dp19_tri_iobuf_15 IOBUF {hdi_primitives:abstract:no file specified} -autohide -attr @cell(#000000) IOBUF -pg 1 -lvl 1 -x 280 -y 1700
load inst shield_dp0_dp19_tri_iobuf_16 IOBUF {hdi_primitives:abstract:no file specified} -autohide -attr @cell(#000000) IOBUF -pg 1 -lvl 1 -x 280 -y 1810
load inst shield_dp0_dp19_tri_iobuf_17 IOBUF {hdi_primitives:abstract:no file specified} -autohide -attr @cell(#000000) IOBUF -pg 1 -lvl 1 -x 280 -y 1920
load inst shield_dp0_dp19_tri_iobuf_18 IOBUF {hdi_primitives:abstract:no file specified} -autohide -attr @cell(#000000) IOBUF -pg 1 -lvl 1 -x 280 -y 2030
load inst shield_dp0_dp19_tri_iobuf_19 IOBUF {hdi_primitives:abstract:no file specified} -autohide -attr @cell(#000000) IOBUF -pg 1 -lvl 1 -x 280 -y 2140
load inst shield_dp0_dp19_tri_iobuf_2 IOBUF {hdi_primitives:abstract:no file specified} -autohide -attr @cell(#000000) IOBUF -pg 1 -lvl 1 -x 280 -y 270
load inst shield_dp0_dp19_tri_iobuf_3 IOBUF {hdi_primitives:abstract:no file specified} -autohide -attr @cell(#000000) IOBUF -pg 1 -lvl 1 -x 280 -y 380
load inst shield_dp0_dp19_tri_iobuf_4 IOBUF {hdi_primitives:abstract:no file specified} -autohide -attr @cell(#000000) IOBUF -pg 1 -lvl 1 -x 280 -y 490
load inst shield_dp0_dp19_tri_iobuf_5 IOBUF {hdi_primitives:abstract:no file specified} -autohide -attr @cell(#000000) IOBUF -pg 1 -lvl 1 -x 280 -y 600
load inst shield_dp0_dp19_tri_iobuf_6 IOBUF {hdi_primitives:abstract:no file specified} -autohide -attr @cell(#000000) IOBUF -pg 1 -lvl 1 -x 280 -y 710
load inst shield_dp0_dp19_tri_iobuf_7 IOBUF {hdi_primitives:abstract:no file specified} -autohide -attr @cell(#000000) IOBUF -pg 1 -lvl 1 -x 280 -y 820
load inst shield_dp0_dp19_tri_iobuf_8 IOBUF {hdi_primitives:abstract:no file specified} -autohide -attr @cell(#000000) IOBUF -pg 1 -lvl 1 -x 280 -y 930
load inst shield_dp0_dp19_tri_iobuf_9 IOBUF {hdi_primitives:abstract:no file specified} -autohide -attr @cell(#000000) IOBUF -pg 1 -lvl 1 -x 280 -y 1040
load inst shield_dp26_dp41_tri_iobuf_0 IOBUF {hdi_primitives:abstract:no file specified} -autohide -attr @cell(#000000) IOBUF -pg 1 -lvl 1 -x 280 -y 4660
load inst shield_dp26_dp41_tri_iobuf_1 IOBUF {hdi_primitives:abstract:no file specified} -autohide -attr @cell(#000000) IOBUF -pg 1 -lvl 1 -x 280 -y 4770
load inst shield_dp26_dp41_tri_iobuf_10 IOBUF {hdi_primitives:abstract:no file specified} -autohide -attr @cell(#000000) IOBUF -pg 1 -lvl 1 -x 280 -y 5760
load inst shield_dp26_dp41_tri_iobuf_11 IOBUF {hdi_primitives:abstract:no file specified} -autohide -attr @cell(#000000) IOBUF -pg 1 -lvl 1 -x 280 -y 5870
load inst shield_dp26_dp41_tri_iobuf_12 IOBUF {hdi_primitives:abstract:no file specified} -autohide -attr @cell(#000000) IOBUF -pg 1 -lvl 1 -x 280 -y 5980
load inst shield_dp26_dp41_tri_iobuf_13 IOBUF {hdi_primitives:abstract:no file specified} -autohide -attr @cell(#000000) IOBUF -pg 1 -lvl 1 -x 280 -y 6090
load inst shield_dp26_dp41_tri_iobuf_14 IOBUF {hdi_primitives:abstract:no file specified} -autohide -attr @cell(#000000) IOBUF -pg 1 -lvl 1 -x 280 -y 6200
load inst shield_dp26_dp41_tri_iobuf_15 IOBUF {hdi_primitives:abstract:no file specified} -autohide -attr @cell(#000000) IOBUF -pg 1 -lvl 1 -x 280 -y 6310
load inst shield_dp26_dp41_tri_iobuf_2 IOBUF {hdi_primitives:abstract:no file specified} -autohide -attr @cell(#000000) IOBUF -pg 1 -lvl 1 -x 280 -y 4880
load inst shield_dp26_dp41_tri_iobuf_3 IOBUF {hdi_primitives:abstract:no file specified} -autohide -attr @cell(#000000) IOBUF -pg 1 -lvl 1 -x 280 -y 4990
load inst shield_dp26_dp41_tri_iobuf_4 IOBUF {hdi_primitives:abstract:no file specified} -autohide -attr @cell(#000000) IOBUF -pg 1 -lvl 1 -x 280 -y 5100
load inst shield_dp26_dp41_tri_iobuf_5 IOBUF {hdi_primitives:abstract:no file specified} -autohide -attr @cell(#000000) IOBUF -pg 1 -lvl 1 -x 280 -y 5210
load inst shield_dp26_dp41_tri_iobuf_6 IOBUF {hdi_primitives:abstract:no file specified} -autohide -attr @cell(#000000) IOBUF -pg 1 -lvl 1 -x 280 -y 5320
load inst shield_dp26_dp41_tri_iobuf_7 IOBUF {hdi_primitives:abstract:no file specified} -autohide -attr @cell(#000000) IOBUF -pg 1 -lvl 1 -x 280 -y 5430
load inst shield_dp26_dp41_tri_iobuf_8 IOBUF {hdi_primitives:abstract:no file specified} -autohide -attr @cell(#000000) IOBUF -pg 1 -lvl 1 -x 280 -y 5540
load inst shield_dp26_dp41_tri_iobuf_9 IOBUF {hdi_primitives:abstract:no file specified} -autohide -attr @cell(#000000) IOBUF -pg 1 -lvl 1 -x 280 -y 5650
load inst spi_io0_iobuf IOBUF {hdi_primitives:abstract:no file specified} -autohide -attr @cell(#000000) IOBUF -pg 1 -lvl 1 -x 280 -y 3480
load inst spi_io1_iobuf IOBUF {hdi_primitives:abstract:no file specified} -autohide -attr @cell(#000000) IOBUF -pg 1 -lvl 1 -x 280 -y 3640
load inst spi_sck_iobuf IOBUF {hdi_primitives:abstract:no file specified} -autohide -attr @cell(#000000) IOBUF -pg 1 -lvl 1 -x 280 -y 4360
load inst spi_ss_iobuf IOBUF {hdi_primitives:abstract:no file specified} -autohide -attr @cell(#000000) IOBUF -pg 1 -lvl 1 -x 280 -y 4540
load net I -pin eth_mdio_mdc_mdio_iobuf I -pin mbv_system_i eth_mdio_mdc_mdio_o
netloc I 1 0 3 180 3710 480J 3790 1400
load net T -pin eth_mdio_mdc_mdio_iobuf T -pin mbv_system_i eth_mdio_mdc_mdio_t
netloc T 1 0 3 160 3830 NJ 3830 1720
load net dip_switches_4bits_tri_i[0] -attr @rip(#000000) dip_switches_4bits_tri_i[0] -port dip_switches_4bits_tri_i[0] -pin mbv_system_i dip_switches_4bits_tri_i[0]
load net dip_switches_4bits_tri_i[1] -attr @rip(#000000) dip_switches_4bits_tri_i[1] -port dip_switches_4bits_tri_i[1] -pin mbv_system_i dip_switches_4bits_tri_i[1]
load net dip_switches_4bits_tri_i[2] -attr @rip(#000000) dip_switches_4bits_tri_i[2] -port dip_switches_4bits_tri_i[2] -pin mbv_system_i dip_switches_4bits_tri_i[2]
load net dip_switches_4bits_tri_i[3] -attr @rip(#000000) dip_switches_4bits_tri_i[3] -port dip_switches_4bits_tri_i[3] -pin mbv_system_i dip_switches_4bits_tri_i[3]
load net eth_mdio_mdc_mdc -port eth_mdio_mdc_mdc -pin mbv_system_i eth_mdio_mdc_mdc
netloc eth_mdio_mdc_mdc 1 2 1 NJ 2870
load net eth_mdio_mdc_mdio_i -pin eth_mdio_mdc_mdio_iobuf O -pin mbv_system_i eth_mdio_mdc_mdio_i
netloc eth_mdio_mdc_mdio_i 1 1 1 460 2990n
load net eth_mdio_mdc_mdio_io -port eth_mdio_mdc_mdio_io -pin eth_mdio_mdc_mdio_iobuf IO
netloc eth_mdio_mdc_mdio_io 1 1 2 440J 3810 NJ
load net eth_mii_col -port eth_mii_col -pin mbv_system_i eth_mii_col
netloc eth_mii_col 1 0 2 NJ 3010 NJ
load net eth_mii_crs -port eth_mii_crs -pin mbv_system_i eth_mii_crs
netloc eth_mii_crs 1 0 2 NJ 3030 NJ
load net eth_mii_rst_n -port eth_mii_rst_n -pin mbv_system_i eth_mii_rst_n
netloc eth_mii_rst_n 1 2 1 NJ 2930
load net eth_mii_rx_clk -port eth_mii_rx_clk -pin mbv_system_i eth_mii_rx_clk
netloc eth_mii_rx_clk 1 0 2 NJ 3050 NJ
load net eth_mii_rx_dv -port eth_mii_rx_dv -pin mbv_system_i eth_mii_rx_dv
netloc eth_mii_rx_dv 1 0 2 NJ 3070 NJ
load net eth_mii_rx_er -port eth_mii_rx_er -pin mbv_system_i eth_mii_rx_er
netloc eth_mii_rx_er 1 0 2 NJ 3090 NJ
load net eth_mii_rxd[0] -attr @rip(#000000) eth_mii_rxd[0] -port eth_mii_rxd[0] -pin mbv_system_i eth_mii_rxd[0]
load net eth_mii_rxd[1] -attr @rip(#000000) eth_mii_rxd[1] -port eth_mii_rxd[1] -pin mbv_system_i eth_mii_rxd[1]
load net eth_mii_rxd[2] -attr @rip(#000000) eth_mii_rxd[2] -port eth_mii_rxd[2] -pin mbv_system_i eth_mii_rxd[2]
load net eth_mii_rxd[3] -attr @rip(#000000) eth_mii_rxd[3] -port eth_mii_rxd[3] -pin mbv_system_i eth_mii_rxd[3]
load net eth_mii_tx_clk -port eth_mii_tx_clk -pin mbv_system_i eth_mii_tx_clk
netloc eth_mii_tx_clk 1 0 2 NJ 3130 NJ
load net eth_mii_tx_en -port eth_mii_tx_en -pin mbv_system_i eth_mii_tx_en
netloc eth_mii_tx_en 1 2 1 NJ 2950
load net eth_mii_txd[0] -attr @rip(#000000) eth_mii_txd[0] -port eth_mii_txd[0] -pin mbv_system_i eth_mii_txd[0]
load net eth_mii_txd[1] -attr @rip(#000000) eth_mii_txd[1] -port eth_mii_txd[1] -pin mbv_system_i eth_mii_txd[1]
load net eth_mii_txd[2] -attr @rip(#000000) eth_mii_txd[2] -port eth_mii_txd[2] -pin mbv_system_i eth_mii_txd[2]
load net eth_mii_txd[3] -attr @rip(#000000) eth_mii_txd[3] -port eth_mii_txd[3] -pin mbv_system_i eth_mii_txd[3]
load net i2c_pullups_tri_o[0] -attr @rip(#000000) i2c_pullups_tri_o[0] -port i2c_pullups_tri_o[0] -pin mbv_system_i i2c_pullups_tri_o[0]
load net i2c_pullups_tri_o[1] -attr @rip(#000000) i2c_pullups_tri_o[1] -port i2c_pullups_tri_o[1] -pin mbv_system_i i2c_pullups_tri_o[1]
load net i2c_scl_i -pin i2c_scl_iobuf O -pin mbv_system_i i2c_scl_i
netloc i2c_scl_i 1 1 1 620 3150n
load net i2c_scl_io -port i2c_scl_io -pin i2c_scl_iobuf IO
netloc i2c_scl_io 1 1 2 NJ 3910 NJ
load net i2c_scl_o -pin i2c_scl_iobuf I -pin mbv_system_i i2c_scl_o
netloc i2c_scl_o 1 0 3 160 3970 NJ 3970 1700
load net i2c_scl_t -pin i2c_scl_iobuf T -pin mbv_system_i i2c_scl_t
netloc i2c_scl_t 1 0 3 180 3850 NJ 3850 1680
load net i2c_sda_i -pin i2c_sda_iobuf O -pin mbv_system_i i2c_sda_i
netloc i2c_sda_i 1 1 1 700 3170n
load net i2c_sda_io -port i2c_sda_io -pin i2c_sda_iobuf IO
netloc i2c_sda_io 1 1 2 NJ 4210 NJ
load net i2c_sda_o -pin i2c_sda_iobuf I -pin mbv_system_i i2c_sda_o
netloc i2c_sda_o 1 0 3 140 3990 NJ 3990 1480
load net i2c_sda_t -pin i2c_sda_iobuf T -pin mbv_system_i i2c_sda_t
netloc i2c_sda_t 1 0 3 100 4150 NJ 4150 1540
load net led_4bits_tri_o[0] -attr @rip(#000000) led_4bits_tri_o[0] -port led_4bits_tri_o[0] -pin mbv_system_i led_4bits_tri_o[0]
load net led_4bits_tri_o[1] -attr @rip(#000000) led_4bits_tri_o[1] -port led_4bits_tri_o[1] -pin mbv_system_i led_4bits_tri_o[1]
load net led_4bits_tri_o[2] -attr @rip(#000000) led_4bits_tri_o[2] -port led_4bits_tri_o[2] -pin mbv_system_i led_4bits_tri_o[2]
load net led_4bits_tri_o[3] -attr @rip(#000000) led_4bits_tri_o[3] -port led_4bits_tri_o[3] -pin mbv_system_i led_4bits_tri_o[3]
load net push_buttons_4bits_tri_i[0] -attr @rip(#000000) push_buttons_4bits_tri_i[0] -pin mbv_system_i push_buttons_4bits_tri_i[0] -port push_buttons_4bits_tri_i[0]
load net push_buttons_4bits_tri_i[1] -attr @rip(#000000) push_buttons_4bits_tri_i[1] -pin mbv_system_i push_buttons_4bits_tri_i[1] -port push_buttons_4bits_tri_i[1]
load net push_buttons_4bits_tri_i[2] -attr @rip(#000000) push_buttons_4bits_tri_i[2] -pin mbv_system_i push_buttons_4bits_tri_i[2] -port push_buttons_4bits_tri_i[2]
load net push_buttons_4bits_tri_i[3] -attr @rip(#000000) push_buttons_4bits_tri_i[3] -pin mbv_system_i push_buttons_4bits_tri_i[3] -port push_buttons_4bits_tri_i[3]
load net qspi_flash_io0_i -pin mbv_system_i qspi_flash_io0_i -pin qspi_flash_io0_iobuf O
netloc qspi_flash_io0_i 1 1 1 820 2280n
load net qspi_flash_io0_io -port qspi_flash_io0_io -pin qspi_flash_io0_iobuf IO
netloc qspi_flash_io0_io 1 1 2 NJ 2260 NJ
load net qspi_flash_io0_o -pin mbv_system_i qspi_flash_io0_o -pin qspi_flash_io0_iobuf I
netloc qspi_flash_io0_o 1 0 3 140 2320 NJ 2320 1640
load net qspi_flash_io0_t -pin mbv_system_i qspi_flash_io0_t -pin qspi_flash_io0_iobuf T
netloc qspi_flash_io0_t 1 0 3 160 2440 NJ 2440 1600
load net qspi_flash_io1_i -pin mbv_system_i qspi_flash_io1_i -pin qspi_flash_io1_iobuf O
netloc qspi_flash_io1_i 1 1 1 800 2400n
load net qspi_flash_io1_io -port qspi_flash_io1_io -pin qspi_flash_io1_iobuf IO
netloc qspi_flash_io1_io 1 1 2 NJ 2380 NJ
load net qspi_flash_io1_o -pin mbv_system_i qspi_flash_io1_o -pin qspi_flash_io1_iobuf I
netloc qspi_flash_io1_o 1 0 3 140 2670 NJ 2670 1580
load net qspi_flash_io1_t -pin mbv_system_i qspi_flash_io1_t -pin qspi_flash_io1_iobuf T
netloc qspi_flash_io1_t 1 0 3 180 2690 NJ 2690 1560
load net qspi_flash_io2_i -pin mbv_system_i qspi_flash_io2_i -pin qspi_flash_io2_iobuf O
netloc qspi_flash_io2_i 1 1 1 760 2520n
load net qspi_flash_io2_io -port qspi_flash_io2_io -pin qspi_flash_io2_iobuf IO
netloc qspi_flash_io2_io 1 1 2 NJ 2500 NJ
load net qspi_flash_io2_o -pin mbv_system_i qspi_flash_io2_o -pin qspi_flash_io2_iobuf I
netloc qspi_flash_io2_o 1 0 3 80 2710 NJ 2710 1520
load net qspi_flash_io2_t -pin mbv_system_i qspi_flash_io2_t -pin qspi_flash_io2_iobuf T
netloc qspi_flash_io2_t 1 0 3 100 2870 620J 2790 1440
load net qspi_flash_io3_i -pin mbv_system_i qspi_flash_io3_i -pin qspi_flash_io3_iobuf O
netloc qspi_flash_io3_i 1 1 1 740 2630n
load net qspi_flash_io3_io -port qspi_flash_io3_io -pin qspi_flash_io3_iobuf IO
netloc qspi_flash_io3_io 1 1 2 NJ 2610 NJ
load net qspi_flash_io3_o -pin mbv_system_i qspi_flash_io3_o -pin qspi_flash_io3_iobuf I
netloc qspi_flash_io3_o 1 0 3 120 2730 NJ 2730 1660
load net qspi_flash_io3_t -pin mbv_system_i qspi_flash_io3_t -pin qspi_flash_io3_iobuf T
netloc qspi_flash_io3_t 1 0 3 160 2750 NJ 2750 1620
load net qspi_flash_sck_i -pin mbv_system_i qspi_flash_sck_i -pin qspi_flash_sck_iobuf O
netloc qspi_flash_sck_i 1 1 1 720 2830n
load net qspi_flash_sck_io -port qspi_flash_sck_io -pin qspi_flash_sck_iobuf IO
netloc qspi_flash_sck_io 1 1 2 460J 2770 NJ
load net qspi_flash_sck_o -pin mbv_system_i qspi_flash_sck_o -pin qspi_flash_sck_iobuf I
netloc qspi_flash_sck_o 1 0 3 80 2890 700J 2810 1360
load net qspi_flash_sck_t -pin mbv_system_i qspi_flash_sck_t -pin qspi_flash_sck_iobuf T
netloc qspi_flash_sck_t 1 0 3 40 3430 580J 3690 1660
load net qspi_flash_ss_i -pin mbv_system_i qspi_flash_ss_i -pin qspi_flash_ss_iobuf O
netloc qspi_flash_ss_i 1 1 1 720 3310n
load net qspi_flash_ss_io -port qspi_flash_ss_io -pin qspi_flash_ss_iobuf IO
netloc qspi_flash_ss_io 1 1 2 NJ 4070 NJ
load net qspi_flash_ss_o -pin mbv_system_i qspi_flash_ss_o -pin qspi_flash_ss_iobuf I
netloc qspi_flash_ss_o 1 0 3 180 4010 NJ 4010 1380
load net qspi_flash_ss_t -pin mbv_system_i qspi_flash_ss_t -pin qspi_flash_ss_iobuf T
netloc qspi_flash_ss_t 1 0 3 160 4130 NJ 4130 1500
load net reset -pin mbv_system_i reset -port reset
netloc reset 1 0 2 NJ 3330 NJ
load net rgb_led_tri_o[0] -attr @rip(#000000) rgb_led_tri_o[0] -pin mbv_system_i rgb_led_tri_o[0] -port rgb_led_tri_o[0]
load net rgb_led_tri_o[10] -attr @rip(#000000) rgb_led_tri_o[10] -pin mbv_system_i rgb_led_tri_o[10] -port rgb_led_tri_o[10]
load net rgb_led_tri_o[11] -attr @rip(#000000) rgb_led_tri_o[11] -pin mbv_system_i rgb_led_tri_o[11] -port rgb_led_tri_o[11]
load net rgb_led_tri_o[1] -attr @rip(#000000) rgb_led_tri_o[1] -pin mbv_system_i rgb_led_tri_o[1] -port rgb_led_tri_o[1]
load net rgb_led_tri_o[2] -attr @rip(#000000) rgb_led_tri_o[2] -pin mbv_system_i rgb_led_tri_o[2] -port rgb_led_tri_o[2]
load net rgb_led_tri_o[3] -attr @rip(#000000) rgb_led_tri_o[3] -pin mbv_system_i rgb_led_tri_o[3] -port rgb_led_tri_o[3]
load net rgb_led_tri_o[4] -attr @rip(#000000) rgb_led_tri_o[4] -pin mbv_system_i rgb_led_tri_o[4] -port rgb_led_tri_o[4]
load net rgb_led_tri_o[5] -attr @rip(#000000) rgb_led_tri_o[5] -pin mbv_system_i rgb_led_tri_o[5] -port rgb_led_tri_o[5]
load net rgb_led_tri_o[6] -attr @rip(#000000) rgb_led_tri_o[6] -pin mbv_system_i rgb_led_tri_o[6] -port rgb_led_tri_o[6]
load net rgb_led_tri_o[7] -attr @rip(#000000) rgb_led_tri_o[7] -pin mbv_system_i rgb_led_tri_o[7] -port rgb_led_tri_o[7]
load net rgb_led_tri_o[8] -attr @rip(#000000) rgb_led_tri_o[8] -pin mbv_system_i rgb_led_tri_o[8] -port rgb_led_tri_o[8]
load net rgb_led_tri_o[9] -attr @rip(#000000) rgb_led_tri_o[9] -pin mbv_system_i rgb_led_tri_o[9] -port rgb_led_tri_o[9]
load net shield_dp0_dp19_tri_i[0] -attr @rip(#000000) 0 -pin mbv_system_i shield_dp0_dp19_tri_i[0] -pin shield_dp0_dp19_tri_iobuf_0 O
load net shield_dp0_dp19_tri_i[10] -attr @rip(#000000) 10 -pin mbv_system_i shield_dp0_dp19_tri_i[10] -pin shield_dp0_dp19_tri_iobuf_10 O
load net shield_dp0_dp19_tri_i[11] -attr @rip(#000000) 11 -pin mbv_system_i shield_dp0_dp19_tri_i[11] -pin shield_dp0_dp19_tri_iobuf_11 O
load net shield_dp0_dp19_tri_i[12] -attr @rip(#000000) 12 -pin mbv_system_i shield_dp0_dp19_tri_i[12] -pin shield_dp0_dp19_tri_iobuf_12 O
load net shield_dp0_dp19_tri_i[13] -attr @rip(#000000) 13 -pin mbv_system_i shield_dp0_dp19_tri_i[13] -pin shield_dp0_dp19_tri_iobuf_13 O
load net shield_dp0_dp19_tri_i[14] -attr @rip(#000000) 14 -pin mbv_system_i shield_dp0_dp19_tri_i[14] -pin shield_dp0_dp19_tri_iobuf_14 O
load net shield_dp0_dp19_tri_i[15] -attr @rip(#000000) 15 -pin mbv_system_i shield_dp0_dp19_tri_i[15] -pin shield_dp0_dp19_tri_iobuf_15 O
load net shield_dp0_dp19_tri_i[16] -attr @rip(#000000) 16 -pin mbv_system_i shield_dp0_dp19_tri_i[16] -pin shield_dp0_dp19_tri_iobuf_16 O
load net shield_dp0_dp19_tri_i[17] -attr @rip(#000000) 17 -pin mbv_system_i shield_dp0_dp19_tri_i[17] -pin shield_dp0_dp19_tri_iobuf_17 O
load net shield_dp0_dp19_tri_i[18] -attr @rip(#000000) 18 -pin mbv_system_i shield_dp0_dp19_tri_i[18] -pin shield_dp0_dp19_tri_iobuf_18 O
load net shield_dp0_dp19_tri_i[19] -attr @rip(#000000) 19 -pin mbv_system_i shield_dp0_dp19_tri_i[19] -pin shield_dp0_dp19_tri_iobuf_19 O
load net shield_dp0_dp19_tri_i[1] -attr @rip(#000000) 1 -pin mbv_system_i shield_dp0_dp19_tri_i[1] -pin shield_dp0_dp19_tri_iobuf_1 O
load net shield_dp0_dp19_tri_i[2] -attr @rip(#000000) 2 -pin mbv_system_i shield_dp0_dp19_tri_i[2] -pin shield_dp0_dp19_tri_iobuf_2 O
load net shield_dp0_dp19_tri_i[3] -attr @rip(#000000) 3 -pin mbv_system_i shield_dp0_dp19_tri_i[3] -pin shield_dp0_dp19_tri_iobuf_3 O
load net shield_dp0_dp19_tri_i[4] -attr @rip(#000000) 4 -pin mbv_system_i shield_dp0_dp19_tri_i[4] -pin shield_dp0_dp19_tri_iobuf_4 O
load net shield_dp0_dp19_tri_i[5] -attr @rip(#000000) 5 -pin mbv_system_i shield_dp0_dp19_tri_i[5] -pin shield_dp0_dp19_tri_iobuf_5 O
load net shield_dp0_dp19_tri_i[6] -attr @rip(#000000) 6 -pin mbv_system_i shield_dp0_dp19_tri_i[6] -pin shield_dp0_dp19_tri_iobuf_6 O
load net shield_dp0_dp19_tri_i[7] -attr @rip(#000000) 7 -pin mbv_system_i shield_dp0_dp19_tri_i[7] -pin shield_dp0_dp19_tri_iobuf_7 O
load net shield_dp0_dp19_tri_i[8] -attr @rip(#000000) 8 -pin mbv_system_i shield_dp0_dp19_tri_i[8] -pin shield_dp0_dp19_tri_iobuf_8 O
load net shield_dp0_dp19_tri_i[9] -attr @rip(#000000) 9 -pin mbv_system_i shield_dp0_dp19_tri_i[9] -pin shield_dp0_dp19_tri_iobuf_9 O
load net shield_dp0_dp19_tri_io[0] -attr @rip(#000000) shield_dp0_dp19_tri_io[0] -port shield_dp0_dp19_tri_io[0] -pin shield_dp0_dp19_tri_iobuf_0 IO
load net shield_dp0_dp19_tri_io[10] -attr @rip(#000000) shield_dp0_dp19_tri_io[10] -port shield_dp0_dp19_tri_io[10] -pin shield_dp0_dp19_tri_iobuf_10 IO
load net shield_dp0_dp19_tri_io[11] -attr @rip(#000000) shield_dp0_dp19_tri_io[11] -port shield_dp0_dp19_tri_io[11] -pin shield_dp0_dp19_tri_iobuf_11 IO
load net shield_dp0_dp19_tri_io[12] -attr @rip(#000000) shield_dp0_dp19_tri_io[12] -port shield_dp0_dp19_tri_io[12] -pin shield_dp0_dp19_tri_iobuf_12 IO
load net shield_dp0_dp19_tri_io[13] -attr @rip(#000000) shield_dp0_dp19_tri_io[13] -port shield_dp0_dp19_tri_io[13] -pin shield_dp0_dp19_tri_iobuf_13 IO
load net shield_dp0_dp19_tri_io[14] -attr @rip(#000000) shield_dp0_dp19_tri_io[14] -port shield_dp0_dp19_tri_io[14] -pin shield_dp0_dp19_tri_iobuf_14 IO
load net shield_dp0_dp19_tri_io[15] -attr @rip(#000000) shield_dp0_dp19_tri_io[15] -port shield_dp0_dp19_tri_io[15] -pin shield_dp0_dp19_tri_iobuf_15 IO
load net shield_dp0_dp19_tri_io[16] -attr @rip(#000000) shield_dp0_dp19_tri_io[16] -port shield_dp0_dp19_tri_io[16] -pin shield_dp0_dp19_tri_iobuf_16 IO
load net shield_dp0_dp19_tri_io[17] -attr @rip(#000000) shield_dp0_dp19_tri_io[17] -port shield_dp0_dp19_tri_io[17] -pin shield_dp0_dp19_tri_iobuf_17 IO
load net shield_dp0_dp19_tri_io[18] -attr @rip(#000000) shield_dp0_dp19_tri_io[18] -port shield_dp0_dp19_tri_io[18] -pin shield_dp0_dp19_tri_iobuf_18 IO
load net shield_dp0_dp19_tri_io[19] -attr @rip(#000000) shield_dp0_dp19_tri_io[19] -port shield_dp0_dp19_tri_io[19] -pin shield_dp0_dp19_tri_iobuf_19 IO
load net shield_dp0_dp19_tri_io[1] -attr @rip(#000000) shield_dp0_dp19_tri_io[1] -port shield_dp0_dp19_tri_io[1] -pin shield_dp0_dp19_tri_iobuf_1 IO
load net shield_dp0_dp19_tri_io[2] -attr @rip(#000000) shield_dp0_dp19_tri_io[2] -port shield_dp0_dp19_tri_io[2] -pin shield_dp0_dp19_tri_iobuf_2 IO
load net shield_dp0_dp19_tri_io[3] -attr @rip(#000000) shield_dp0_dp19_tri_io[3] -port shield_dp0_dp19_tri_io[3] -pin shield_dp0_dp19_tri_iobuf_3 IO
load net shield_dp0_dp19_tri_io[4] -attr @rip(#000000) shield_dp0_dp19_tri_io[4] -port shield_dp0_dp19_tri_io[4] -pin shield_dp0_dp19_tri_iobuf_4 IO
load net shield_dp0_dp19_tri_io[5] -attr @rip(#000000) shield_dp0_dp19_tri_io[5] -port shield_dp0_dp19_tri_io[5] -pin shield_dp0_dp19_tri_iobuf_5 IO
load net shield_dp0_dp19_tri_io[6] -attr @rip(#000000) shield_dp0_dp19_tri_io[6] -port shield_dp0_dp19_tri_io[6] -pin shield_dp0_dp19_tri_iobuf_6 IO
load net shield_dp0_dp19_tri_io[7] -attr @rip(#000000) shield_dp0_dp19_tri_io[7] -port shield_dp0_dp19_tri_io[7] -pin shield_dp0_dp19_tri_iobuf_7 IO
load net shield_dp0_dp19_tri_io[8] -attr @rip(#000000) shield_dp0_dp19_tri_io[8] -port shield_dp0_dp19_tri_io[8] -pin shield_dp0_dp19_tri_iobuf_8 IO
load net shield_dp0_dp19_tri_io[9] -attr @rip(#000000) shield_dp0_dp19_tri_io[9] -port shield_dp0_dp19_tri_io[9] -pin shield_dp0_dp19_tri_iobuf_9 IO
load net shield_dp0_dp19_tri_o_0[0] -attr @rip(#000000) shield_dp0_dp19_tri_o[0] -pin mbv_system_i shield_dp0_dp19_tri_o[0] -pin shield_dp0_dp19_tri_iobuf_0 I
load net shield_dp0_dp19_tri_o_10[10] -attr @rip(#000000) shield_dp0_dp19_tri_o[10] -pin mbv_system_i shield_dp0_dp19_tri_o[10] -pin shield_dp0_dp19_tri_iobuf_10 I
load net shield_dp0_dp19_tri_o_11[11] -attr @rip(#000000) shield_dp0_dp19_tri_o[11] -pin mbv_system_i shield_dp0_dp19_tri_o[11] -pin shield_dp0_dp19_tri_iobuf_11 I
load net shield_dp0_dp19_tri_o_12[12] -attr @rip(#000000) shield_dp0_dp19_tri_o[12] -pin mbv_system_i shield_dp0_dp19_tri_o[12] -pin shield_dp0_dp19_tri_iobuf_12 I
load net shield_dp0_dp19_tri_o_13[13] -attr @rip(#000000) shield_dp0_dp19_tri_o[13] -pin mbv_system_i shield_dp0_dp19_tri_o[13] -pin shield_dp0_dp19_tri_iobuf_13 I
load net shield_dp0_dp19_tri_o_14[14] -attr @rip(#000000) shield_dp0_dp19_tri_o[14] -pin mbv_system_i shield_dp0_dp19_tri_o[14] -pin shield_dp0_dp19_tri_iobuf_14 I
load net shield_dp0_dp19_tri_o_15[15] -attr @rip(#000000) shield_dp0_dp19_tri_o[15] -pin mbv_system_i shield_dp0_dp19_tri_o[15] -pin shield_dp0_dp19_tri_iobuf_15 I
load net shield_dp0_dp19_tri_o_16[16] -attr @rip(#000000) shield_dp0_dp19_tri_o[16] -pin mbv_system_i shield_dp0_dp19_tri_o[16] -pin shield_dp0_dp19_tri_iobuf_16 I
load net shield_dp0_dp19_tri_o_17[17] -attr @rip(#000000) shield_dp0_dp19_tri_o[17] -pin mbv_system_i shield_dp0_dp19_tri_o[17] -pin shield_dp0_dp19_tri_iobuf_17 I
load net shield_dp0_dp19_tri_o_18[18] -attr @rip(#000000) shield_dp0_dp19_tri_o[18] -pin mbv_system_i shield_dp0_dp19_tri_o[18] -pin shield_dp0_dp19_tri_iobuf_18 I
load net shield_dp0_dp19_tri_o_19[19] -attr @rip(#000000) shield_dp0_dp19_tri_o[19] -pin mbv_system_i shield_dp0_dp19_tri_o[19] -pin shield_dp0_dp19_tri_iobuf_19 I
load net shield_dp0_dp19_tri_o_1[1] -attr @rip(#000000) shield_dp0_dp19_tri_o[1] -pin mbv_system_i shield_dp0_dp19_tri_o[1] -pin shield_dp0_dp19_tri_iobuf_1 I
load net shield_dp0_dp19_tri_o_2[2] -attr @rip(#000000) shield_dp0_dp19_tri_o[2] -pin mbv_system_i shield_dp0_dp19_tri_o[2] -pin shield_dp0_dp19_tri_iobuf_2 I
load net shield_dp0_dp19_tri_o_3[3] -attr @rip(#000000) shield_dp0_dp19_tri_o[3] -pin mbv_system_i shield_dp0_dp19_tri_o[3] -pin shield_dp0_dp19_tri_iobuf_3 I
load net shield_dp0_dp19_tri_o_4[4] -attr @rip(#000000) shield_dp0_dp19_tri_o[4] -pin mbv_system_i shield_dp0_dp19_tri_o[4] -pin shield_dp0_dp19_tri_iobuf_4 I
load net shield_dp0_dp19_tri_o_5[5] -attr @rip(#000000) shield_dp0_dp19_tri_o[5] -pin mbv_system_i shield_dp0_dp19_tri_o[5] -pin shield_dp0_dp19_tri_iobuf_5 I
load net shield_dp0_dp19_tri_o_6[6] -attr @rip(#000000) shield_dp0_dp19_tri_o[6] -pin mbv_system_i shield_dp0_dp19_tri_o[6] -pin shield_dp0_dp19_tri_iobuf_6 I
load net shield_dp0_dp19_tri_o_7[7] -attr @rip(#000000) shield_dp0_dp19_tri_o[7] -pin mbv_system_i shield_dp0_dp19_tri_o[7] -pin shield_dp0_dp19_tri_iobuf_7 I
load net shield_dp0_dp19_tri_o_8[8] -attr @rip(#000000) shield_dp0_dp19_tri_o[8] -pin mbv_system_i shield_dp0_dp19_tri_o[8] -pin shield_dp0_dp19_tri_iobuf_8 I
load net shield_dp0_dp19_tri_o_9[9] -attr @rip(#000000) shield_dp0_dp19_tri_o[9] -pin mbv_system_i shield_dp0_dp19_tri_o[9] -pin shield_dp0_dp19_tri_iobuf_9 I
load net shield_dp0_dp19_tri_t_0[0] -attr @rip(#000000) shield_dp0_dp19_tri_t[0] -pin mbv_system_i shield_dp0_dp19_tri_t[0] -pin shield_dp0_dp19_tri_iobuf_0 T
load net shield_dp0_dp19_tri_t_10[10] -attr @rip(#000000) shield_dp0_dp19_tri_t[10] -pin mbv_system_i shield_dp0_dp19_tri_t[10] -pin shield_dp0_dp19_tri_iobuf_10 T
load net shield_dp0_dp19_tri_t_11[11] -attr @rip(#000000) shield_dp0_dp19_tri_t[11] -pin mbv_system_i shield_dp0_dp19_tri_t[11] -pin shield_dp0_dp19_tri_iobuf_11 T
load net shield_dp0_dp19_tri_t_12[12] -attr @rip(#000000) shield_dp0_dp19_tri_t[12] -pin mbv_system_i shield_dp0_dp19_tri_t[12] -pin shield_dp0_dp19_tri_iobuf_12 T
load net shield_dp0_dp19_tri_t_13[13] -attr @rip(#000000) shield_dp0_dp19_tri_t[13] -pin mbv_system_i shield_dp0_dp19_tri_t[13] -pin shield_dp0_dp19_tri_iobuf_13 T
load net shield_dp0_dp19_tri_t_14[14] -attr @rip(#000000) shield_dp0_dp19_tri_t[14] -pin mbv_system_i shield_dp0_dp19_tri_t[14] -pin shield_dp0_dp19_tri_iobuf_14 T
load net shield_dp0_dp19_tri_t_15[15] -attr @rip(#000000) shield_dp0_dp19_tri_t[15] -pin mbv_system_i shield_dp0_dp19_tri_t[15] -pin shield_dp0_dp19_tri_iobuf_15 T
load net shield_dp0_dp19_tri_t_16[16] -attr @rip(#000000) shield_dp0_dp19_tri_t[16] -pin mbv_system_i shield_dp0_dp19_tri_t[16] -pin shield_dp0_dp19_tri_iobuf_16 T
load net shield_dp0_dp19_tri_t_17[17] -attr @rip(#000000) shield_dp0_dp19_tri_t[17] -pin mbv_system_i shield_dp0_dp19_tri_t[17] -pin shield_dp0_dp19_tri_iobuf_17 T
load net shield_dp0_dp19_tri_t_18[18] -attr @rip(#000000) shield_dp0_dp19_tri_t[18] -pin mbv_system_i shield_dp0_dp19_tri_t[18] -pin shield_dp0_dp19_tri_iobuf_18 T
load net shield_dp0_dp19_tri_t_19[19] -attr @rip(#000000) shield_dp0_dp19_tri_t[19] -pin mbv_system_i shield_dp0_dp19_tri_t[19] -pin shield_dp0_dp19_tri_iobuf_19 T
load net shield_dp0_dp19_tri_t_1[1] -attr @rip(#000000) shield_dp0_dp19_tri_t[1] -pin mbv_system_i shield_dp0_dp19_tri_t[1] -pin shield_dp0_dp19_tri_iobuf_1 T
load net shield_dp0_dp19_tri_t_2[2] -attr @rip(#000000) shield_dp0_dp19_tri_t[2] -pin mbv_system_i shield_dp0_dp19_tri_t[2] -pin shield_dp0_dp19_tri_iobuf_2 T
load net shield_dp0_dp19_tri_t_3[3] -attr @rip(#000000) shield_dp0_dp19_tri_t[3] -pin mbv_system_i shield_dp0_dp19_tri_t[3] -pin shield_dp0_dp19_tri_iobuf_3 T
load net shield_dp0_dp19_tri_t_4[4] -attr @rip(#000000) shield_dp0_dp19_tri_t[4] -pin mbv_system_i shield_dp0_dp19_tri_t[4] -pin shield_dp0_dp19_tri_iobuf_4 T
load net shield_dp0_dp19_tri_t_5[5] -attr @rip(#000000) shield_dp0_dp19_tri_t[5] -pin mbv_system_i shield_dp0_dp19_tri_t[5] -pin shield_dp0_dp19_tri_iobuf_5 T
load net shield_dp0_dp19_tri_t_6[6] -attr @rip(#000000) shield_dp0_dp19_tri_t[6] -pin mbv_system_i shield_dp0_dp19_tri_t[6] -pin shield_dp0_dp19_tri_iobuf_6 T
load net shield_dp0_dp19_tri_t_7[7] -attr @rip(#000000) shield_dp0_dp19_tri_t[7] -pin mbv_system_i shield_dp0_dp19_tri_t[7] -pin shield_dp0_dp19_tri_iobuf_7 T
load net shield_dp0_dp19_tri_t_8[8] -attr @rip(#000000) shield_dp0_dp19_tri_t[8] -pin mbv_system_i shield_dp0_dp19_tri_t[8] -pin shield_dp0_dp19_tri_iobuf_8 T
load net shield_dp0_dp19_tri_t_9[9] -attr @rip(#000000) shield_dp0_dp19_tri_t[9] -pin mbv_system_i shield_dp0_dp19_tri_t[9] -pin shield_dp0_dp19_tri_iobuf_9 T
load net shield_dp26_dp41_tri_i[0] -attr @rip(#000000) 0 -pin mbv_system_i shield_dp26_dp41_tri_i[0] -pin shield_dp26_dp41_tri_iobuf_0 O
load net shield_dp26_dp41_tri_i[10] -attr @rip(#000000) 10 -pin mbv_system_i shield_dp26_dp41_tri_i[10] -pin shield_dp26_dp41_tri_iobuf_10 O
load net shield_dp26_dp41_tri_i[11] -attr @rip(#000000) 11 -pin mbv_system_i shield_dp26_dp41_tri_i[11] -pin shield_dp26_dp41_tri_iobuf_11 O
load net shield_dp26_dp41_tri_i[12] -attr @rip(#000000) 12 -pin mbv_system_i shield_dp26_dp41_tri_i[12] -pin shield_dp26_dp41_tri_iobuf_12 O
load net shield_dp26_dp41_tri_i[13] -attr @rip(#000000) 13 -pin mbv_system_i shield_dp26_dp41_tri_i[13] -pin shield_dp26_dp41_tri_iobuf_13 O
load net shield_dp26_dp41_tri_i[14] -attr @rip(#000000) 14 -pin mbv_system_i shield_dp26_dp41_tri_i[14] -pin shield_dp26_dp41_tri_iobuf_14 O
load net shield_dp26_dp41_tri_i[15] -attr @rip(#000000) 15 -pin mbv_system_i shield_dp26_dp41_tri_i[15] -pin shield_dp26_dp41_tri_iobuf_15 O
load net shield_dp26_dp41_tri_i[1] -attr @rip(#000000) 1 -pin mbv_system_i shield_dp26_dp41_tri_i[1] -pin shield_dp26_dp41_tri_iobuf_1 O
load net shield_dp26_dp41_tri_i[2] -attr @rip(#000000) 2 -pin mbv_system_i shield_dp26_dp41_tri_i[2] -pin shield_dp26_dp41_tri_iobuf_2 O
load net shield_dp26_dp41_tri_i[3] -attr @rip(#000000) 3 -pin mbv_system_i shield_dp26_dp41_tri_i[3] -pin shield_dp26_dp41_tri_iobuf_3 O
load net shield_dp26_dp41_tri_i[4] -attr @rip(#000000) 4 -pin mbv_system_i shield_dp26_dp41_tri_i[4] -pin shield_dp26_dp41_tri_iobuf_4 O
load net shield_dp26_dp41_tri_i[5] -attr @rip(#000000) 5 -pin mbv_system_i shield_dp26_dp41_tri_i[5] -pin shield_dp26_dp41_tri_iobuf_5 O
load net shield_dp26_dp41_tri_i[6] -attr @rip(#000000) 6 -pin mbv_system_i shield_dp26_dp41_tri_i[6] -pin shield_dp26_dp41_tri_iobuf_6 O
load net shield_dp26_dp41_tri_i[7] -attr @rip(#000000) 7 -pin mbv_system_i shield_dp26_dp41_tri_i[7] -pin shield_dp26_dp41_tri_iobuf_7 O
load net shield_dp26_dp41_tri_i[8] -attr @rip(#000000) 8 -pin mbv_system_i shield_dp26_dp41_tri_i[8] -pin shield_dp26_dp41_tri_iobuf_8 O
load net shield_dp26_dp41_tri_i[9] -attr @rip(#000000) 9 -pin mbv_system_i shield_dp26_dp41_tri_i[9] -pin shield_dp26_dp41_tri_iobuf_9 O
load net shield_dp26_dp41_tri_io[0] -attr @rip(#000000) shield_dp26_dp41_tri_io[0] -port shield_dp26_dp41_tri_io[0] -pin shield_dp26_dp41_tri_iobuf_0 IO
load net shield_dp26_dp41_tri_io[10] -attr @rip(#000000) shield_dp26_dp41_tri_io[10] -port shield_dp26_dp41_tri_io[10] -pin shield_dp26_dp41_tri_iobuf_10 IO
load net shield_dp26_dp41_tri_io[11] -attr @rip(#000000) shield_dp26_dp41_tri_io[11] -port shield_dp26_dp41_tri_io[11] -pin shield_dp26_dp41_tri_iobuf_11 IO
load net shield_dp26_dp41_tri_io[12] -attr @rip(#000000) shield_dp26_dp41_tri_io[12] -port shield_dp26_dp41_tri_io[12] -pin shield_dp26_dp41_tri_iobuf_12 IO
load net shield_dp26_dp41_tri_io[13] -attr @rip(#000000) shield_dp26_dp41_tri_io[13] -port shield_dp26_dp41_tri_io[13] -pin shield_dp26_dp41_tri_iobuf_13 IO
load net shield_dp26_dp41_tri_io[14] -attr @rip(#000000) shield_dp26_dp41_tri_io[14] -port shield_dp26_dp41_tri_io[14] -pin shield_dp26_dp41_tri_iobuf_14 IO
load net shield_dp26_dp41_tri_io[15] -attr @rip(#000000) shield_dp26_dp41_tri_io[15] -port shield_dp26_dp41_tri_io[15] -pin shield_dp26_dp41_tri_iobuf_15 IO
load net shield_dp26_dp41_tri_io[1] -attr @rip(#000000) shield_dp26_dp41_tri_io[1] -port shield_dp26_dp41_tri_io[1] -pin shield_dp26_dp41_tri_iobuf_1 IO
load net shield_dp26_dp41_tri_io[2] -attr @rip(#000000) shield_dp26_dp41_tri_io[2] -port shield_dp26_dp41_tri_io[2] -pin shield_dp26_dp41_tri_iobuf_2 IO
load net shield_dp26_dp41_tri_io[3] -attr @rip(#000000) shield_dp26_dp41_tri_io[3] -port shield_dp26_dp41_tri_io[3] -pin shield_dp26_dp41_tri_iobuf_3 IO
load net shield_dp26_dp41_tri_io[4] -attr @rip(#000000) shield_dp26_dp41_tri_io[4] -port shield_dp26_dp41_tri_io[4] -pin shield_dp26_dp41_tri_iobuf_4 IO
load net shield_dp26_dp41_tri_io[5] -attr @rip(#000000) shield_dp26_dp41_tri_io[5] -port shield_dp26_dp41_tri_io[5] -pin shield_dp26_dp41_tri_iobuf_5 IO
load net shield_dp26_dp41_tri_io[6] -attr @rip(#000000) shield_dp26_dp41_tri_io[6] -port shield_dp26_dp41_tri_io[6] -pin shield_dp26_dp41_tri_iobuf_6 IO
load net shield_dp26_dp41_tri_io[7] -attr @rip(#000000) shield_dp26_dp41_tri_io[7] -port shield_dp26_dp41_tri_io[7] -pin shield_dp26_dp41_tri_iobuf_7 IO
load net shield_dp26_dp41_tri_io[8] -attr @rip(#000000) shield_dp26_dp41_tri_io[8] -port shield_dp26_dp41_tri_io[8] -pin shield_dp26_dp41_tri_iobuf_8 IO
load net shield_dp26_dp41_tri_io[9] -attr @rip(#000000) shield_dp26_dp41_tri_io[9] -port shield_dp26_dp41_tri_io[9] -pin shield_dp26_dp41_tri_iobuf_9 IO
load net shield_dp26_dp41_tri_o_0[0] -attr @rip(#000000) shield_dp26_dp41_tri_o[0] -pin mbv_system_i shield_dp26_dp41_tri_o[0] -pin shield_dp26_dp41_tri_iobuf_0 I
load net shield_dp26_dp41_tri_o_10[10] -attr @rip(#000000) shield_dp26_dp41_tri_o[10] -pin mbv_system_i shield_dp26_dp41_tri_o[10] -pin shield_dp26_dp41_tri_iobuf_10 I
load net shield_dp26_dp41_tri_o_11[11] -attr @rip(#000000) shield_dp26_dp41_tri_o[11] -pin mbv_system_i shield_dp26_dp41_tri_o[11] -pin shield_dp26_dp41_tri_iobuf_11 I
load net shield_dp26_dp41_tri_o_12[12] -attr @rip(#000000) shield_dp26_dp41_tri_o[12] -pin mbv_system_i shield_dp26_dp41_tri_o[12] -pin shield_dp26_dp41_tri_iobuf_12 I
load net shield_dp26_dp41_tri_o_13[13] -attr @rip(#000000) shield_dp26_dp41_tri_o[13] -pin mbv_system_i shield_dp26_dp41_tri_o[13] -pin shield_dp26_dp41_tri_iobuf_13 I
load net shield_dp26_dp41_tri_o_14[14] -attr @rip(#000000) shield_dp26_dp41_tri_o[14] -pin mbv_system_i shield_dp26_dp41_tri_o[14] -pin shield_dp26_dp41_tri_iobuf_14 I
load net shield_dp26_dp41_tri_o_15[15] -attr @rip(#000000) shield_dp26_dp41_tri_o[15] -pin mbv_system_i shield_dp26_dp41_tri_o[15] -pin shield_dp26_dp41_tri_iobuf_15 I
load net shield_dp26_dp41_tri_o_1[1] -attr @rip(#000000) shield_dp26_dp41_tri_o[1] -pin mbv_system_i shield_dp26_dp41_tri_o[1] -pin shield_dp26_dp41_tri_iobuf_1 I
load net shield_dp26_dp41_tri_o_2[2] -attr @rip(#000000) shield_dp26_dp41_tri_o[2] -pin mbv_system_i shield_dp26_dp41_tri_o[2] -pin shield_dp26_dp41_tri_iobuf_2 I
load net shield_dp26_dp41_tri_o_3[3] -attr @rip(#000000) shield_dp26_dp41_tri_o[3] -pin mbv_system_i shield_dp26_dp41_tri_o[3] -pin shield_dp26_dp41_tri_iobuf_3 I
load net shield_dp26_dp41_tri_o_4[4] -attr @rip(#000000) shield_dp26_dp41_tri_o[4] -pin mbv_system_i shield_dp26_dp41_tri_o[4] -pin shield_dp26_dp41_tri_iobuf_4 I
load net shield_dp26_dp41_tri_o_5[5] -attr @rip(#000000) shield_dp26_dp41_tri_o[5] -pin mbv_system_i shield_dp26_dp41_tri_o[5] -pin shield_dp26_dp41_tri_iobuf_5 I
load net shield_dp26_dp41_tri_o_6[6] -attr @rip(#000000) shield_dp26_dp41_tri_o[6] -pin mbv_system_i shield_dp26_dp41_tri_o[6] -pin shield_dp26_dp41_tri_iobuf_6 I
load net shield_dp26_dp41_tri_o_7[7] -attr @rip(#000000) shield_dp26_dp41_tri_o[7] -pin mbv_system_i shield_dp26_dp41_tri_o[7] -pin shield_dp26_dp41_tri_iobuf_7 I
load net shield_dp26_dp41_tri_o_8[8] -attr @rip(#000000) shield_dp26_dp41_tri_o[8] -pin mbv_system_i shield_dp26_dp41_tri_o[8] -pin shield_dp26_dp41_tri_iobuf_8 I
load net shield_dp26_dp41_tri_o_9[9] -attr @rip(#000000) shield_dp26_dp41_tri_o[9] -pin mbv_system_i shield_dp26_dp41_tri_o[9] -pin shield_dp26_dp41_tri_iobuf_9 I
load net shield_dp26_dp41_tri_t_0[0] -attr @rip(#000000) shield_dp26_dp41_tri_t[0] -pin mbv_system_i shield_dp26_dp41_tri_t[0] -pin shield_dp26_dp41_tri_iobuf_0 T
load net shield_dp26_dp41_tri_t_10[10] -attr @rip(#000000) shield_dp26_dp41_tri_t[10] -pin mbv_system_i shield_dp26_dp41_tri_t[10] -pin shield_dp26_dp41_tri_iobuf_10 T
load net shield_dp26_dp41_tri_t_11[11] -attr @rip(#000000) shield_dp26_dp41_tri_t[11] -pin mbv_system_i shield_dp26_dp41_tri_t[11] -pin shield_dp26_dp41_tri_iobuf_11 T
load net shield_dp26_dp41_tri_t_12[12] -attr @rip(#000000) shield_dp26_dp41_tri_t[12] -pin mbv_system_i shield_dp26_dp41_tri_t[12] -pin shield_dp26_dp41_tri_iobuf_12 T
load net shield_dp26_dp41_tri_t_13[13] -attr @rip(#000000) shield_dp26_dp41_tri_t[13] -pin mbv_system_i shield_dp26_dp41_tri_t[13] -pin shield_dp26_dp41_tri_iobuf_13 T
load net shield_dp26_dp41_tri_t_14[14] -attr @rip(#000000) shield_dp26_dp41_tri_t[14] -pin mbv_system_i shield_dp26_dp41_tri_t[14] -pin shield_dp26_dp41_tri_iobuf_14 T
load net shield_dp26_dp41_tri_t_15[15] -attr @rip(#000000) shield_dp26_dp41_tri_t[15] -pin mbv_system_i shield_dp26_dp41_tri_t[15] -pin shield_dp26_dp41_tri_iobuf_15 T
load net shield_dp26_dp41_tri_t_1[1] -attr @rip(#000000) shield_dp26_dp41_tri_t[1] -pin mbv_system_i shield_dp26_dp41_tri_t[1] -pin shield_dp26_dp41_tri_iobuf_1 T
load net shield_dp26_dp41_tri_t_2[2] -attr @rip(#000000) shield_dp26_dp41_tri_t[2] -pin mbv_system_i shield_dp26_dp41_tri_t[2] -pin shield_dp26_dp41_tri_iobuf_2 T
load net shield_dp26_dp41_tri_t_3[3] -attr @rip(#000000) shield_dp26_dp41_tri_t[3] -pin mbv_system_i shield_dp26_dp41_tri_t[3] -pin shield_dp26_dp41_tri_iobuf_3 T
load net shield_dp26_dp41_tri_t_4[4] -attr @rip(#000000) shield_dp26_dp41_tri_t[4] -pin mbv_system_i shield_dp26_dp41_tri_t[4] -pin shield_dp26_dp41_tri_iobuf_4 T
load net shield_dp26_dp41_tri_t_5[5] -attr @rip(#000000) shield_dp26_dp41_tri_t[5] -pin mbv_system_i shield_dp26_dp41_tri_t[5] -pin shield_dp26_dp41_tri_iobuf_5 T
load net shield_dp26_dp41_tri_t_6[6] -attr @rip(#000000) shield_dp26_dp41_tri_t[6] -pin mbv_system_i shield_dp26_dp41_tri_t[6] -pin shield_dp26_dp41_tri_iobuf_6 T
load net shield_dp26_dp41_tri_t_7[7] -attr @rip(#000000) shield_dp26_dp41_tri_t[7] -pin mbv_system_i shield_dp26_dp41_tri_t[7] -pin shield_dp26_dp41_tri_iobuf_7 T
load net shield_dp26_dp41_tri_t_8[8] -attr @rip(#000000) shield_dp26_dp41_tri_t[8] -pin mbv_system_i shield_dp26_dp41_tri_t[8] -pin shield_dp26_dp41_tri_iobuf_8 T
load net shield_dp26_dp41_tri_t_9[9] -attr @rip(#000000) shield_dp26_dp41_tri_t[9] -pin mbv_system_i shield_dp26_dp41_tri_t[9] -pin shield_dp26_dp41_tri_iobuf_9 T
load net spi_io0_i -pin mbv_system_i spi_io0_i -pin spi_io0_iobuf O
netloc spi_io0_i 1 1 1 660 3390n
load net spi_io0_io -port spi_io0_io -pin spi_io0_iobuf IO
netloc spi_io0_io 1 1 2 560J 3710 NJ
load net spi_io0_o -pin mbv_system_i spi_io0_o -pin spi_io0_iobuf I
netloc spi_io0_o 1 0 3 140 3570 540J 3730 1420
load net spi_io0_t -pin mbv_system_i spi_io0_t -pin spi_io0_iobuf T
netloc spi_io0_t 1 0 3 160 3590 520J 3750 1320
load net spi_io1_i -pin mbv_system_i spi_io1_i -pin spi_io1_iobuf O
netloc spi_io1_i 1 1 1 740 3410n
load net spi_io1_io -port spi_io1_io -pin spi_io1_iobuf IO
netloc spi_io1_io 1 1 2 500J 3770 NJ
load net spi_io1_o -pin mbv_system_i spi_io1_o -pin spi_io1_iobuf I
netloc spi_io1_o 1 0 3 60 4270 NJ 4270 1580
load net spi_io1_t -pin mbv_system_i spi_io1_t -pin spi_io1_iobuf T
netloc spi_io1_t 1 0 3 80 4430 NJ 4430 1560
load net spi_sck_i -pin mbv_system_i spi_sck_i -pin spi_sck_iobuf O
netloc spi_sck_i 1 1 1 800 3430n
load net spi_sck_io -port spi_sck_io -pin spi_sck_iobuf IO
netloc spi_sck_io 1 1 2 NJ 4370 NJ
load net spi_sck_o -pin mbv_system_i spi_sck_o -pin spi_sck_iobuf I
netloc spi_sck_o 1 0 3 60 4450 NJ 4450 1520
load net spi_sck_t -pin mbv_system_i spi_sck_t -pin spi_sck_iobuf T
netloc spi_sck_t 1 0 3 180 4470 NJ 4470 1440
load net spi_ss_i -pin mbv_system_i spi_ss_i -pin spi_ss_iobuf O
netloc spi_ss_i 1 1 1 820 3450n
load net spi_ss_io -port spi_ss_io -pin spi_ss_iobuf IO
netloc spi_ss_io 1 1 2 NJ 4550 NJ
load net spi_ss_o -pin mbv_system_i spi_ss_o -pin spi_ss_iobuf I
netloc spi_ss_o 1 0 3 160 4490 NJ 4490 1360
load net spi_ss_t -pin mbv_system_i spi_ss_t -pin spi_ss_iobuf T
netloc spi_ss_t 1 0 3 180 4610 NJ 4610 1460
load net sys_clock -pin mbv_system_i sys_clock -port sys_clock
netloc sys_clock 1 0 2 NJ 3370 680J
load net usb_uart_rxd -pin mbv_system_i usb_uart_rxd -port usb_uart_rxd
netloc usb_uart_rxd 1 0 2 NJ 3550 760J
load net usb_uart_txd -pin mbv_system_i usb_uart_txd -port usb_uart_txd
netloc usb_uart_txd 1 2 1 NJ 3610
load netBundle @dip_switches_4bits_tri_i 4 dip_switches_4bits_tri_i[3] dip_switches_4bits_tri_i[2] dip_switches_4bits_tri_i[1] dip_switches_4bits_tri_i[0] -autobundled
netbloc @dip_switches_4bits_tri_i 1 0 2 NJ 2970 NJ
load netBundle @eth_mii_rxd 4 eth_mii_rxd[3] eth_mii_rxd[2] eth_mii_rxd[1] eth_mii_rxd[0] -autobundled
netbloc @eth_mii_rxd 1 0 2 NJ 3110 NJ
load netBundle @push_buttons_4bits_tri_i 4 push_buttons_4bits_tri_i[3] push_buttons_4bits_tri_i[2] push_buttons_4bits_tri_i[1] push_buttons_4bits_tri_i[0] -autobundled
netbloc @push_buttons_4bits_tri_i 1 0 2 NJ 3190 NJ
load netBundle @shield_dp0_dp19_tri_io 20 shield_dp0_dp19_tri_io[19] shield_dp0_dp19_tri_io[18] shield_dp0_dp19_tri_io[17] shield_dp0_dp19_tri_io[16] shield_dp0_dp19_tri_io[15] shield_dp0_dp19_tri_io[14] shield_dp0_dp19_tri_io[13] shield_dp0_dp19_tri_io[12] shield_dp0_dp19_tri_io[11] shield_dp0_dp19_tri_io[10] shield_dp0_dp19_tri_io[9] shield_dp0_dp19_tri_io[8] shield_dp0_dp19_tri_io[7] shield_dp0_dp19_tri_io[6] shield_dp0_dp19_tri_io[5] shield_dp0_dp19_tri_io[4] shield_dp0_dp19_tri_io[3] shield_dp0_dp19_tri_io[2] shield_dp0_dp19_tri_io[1] shield_dp0_dp19_tri_io[0] -autobundled
netbloc @shield_dp0_dp19_tri_io 1 1 2 760 60 NJ
load netBundle @shield_dp26_dp41_tri_io 16 shield_dp26_dp41_tri_io[15] shield_dp26_dp41_tri_io[14] shield_dp26_dp41_tri_io[13] shield_dp26_dp41_tri_io[12] shield_dp26_dp41_tri_io[11] shield_dp26_dp41_tri_io[10] shield_dp26_dp41_tri_io[9] shield_dp26_dp41_tri_io[8] shield_dp26_dp41_tri_io[7] shield_dp26_dp41_tri_io[6] shield_dp26_dp41_tri_io[5] shield_dp26_dp41_tri_io[4] shield_dp26_dp41_tri_io[3] shield_dp26_dp41_tri_io[2] shield_dp26_dp41_tri_io[1] shield_dp26_dp41_tri_io[0] -autobundled
netbloc @shield_dp26_dp41_tri_io 1 1 2 460 4670 NJ
load netBundle @eth_mii_txd 4 eth_mii_txd[3] eth_mii_txd[2] eth_mii_txd[1] eth_mii_txd[0] -autobundled
netbloc @eth_mii_txd 1 2 1 NJ 2970
load netBundle @i2c_pullups_tri_o 2 i2c_pullups_tri_o[1] i2c_pullups_tri_o[0] -autobundled
netbloc @i2c_pullups_tri_o 1 2 1 NJ 2990
load netBundle @led_4bits_tri_o 4 led_4bits_tri_o[3] led_4bits_tri_o[2] led_4bits_tri_o[1] led_4bits_tri_o[0] -autobundled
netbloc @led_4bits_tri_o 1 2 1 NJ 3090
load netBundle @rgb_led_tri_o 12 rgb_led_tri_o[11] rgb_led_tri_o[10] rgb_led_tri_o[9] rgb_led_tri_o[8] rgb_led_tri_o[7] rgb_led_tri_o[6] rgb_led_tri_o[5] rgb_led_tri_o[4] rgb_led_tri_o[3] rgb_led_tri_o[2] rgb_led_tri_o[1] rgb_led_tri_o[0] -autobundled
netbloc @rgb_led_tri_o 1 2 1 NJ 3350
load netBundle @shield_dp0_dp19_tri_o_19 20 shield_dp0_dp19_tri_o_19[19] shield_dp0_dp19_tri_o_18[18] shield_dp0_dp19_tri_o_17[17] shield_dp0_dp19_tri_o_16[16] shield_dp0_dp19_tri_o_15[15] shield_dp0_dp19_tri_o_14[14] shield_dp0_dp19_tri_o_13[13] shield_dp0_dp19_tri_o_12[12] shield_dp0_dp19_tri_o_11[11] shield_dp0_dp19_tri_o_10[10] shield_dp0_dp19_tri_o_9[9] shield_dp0_dp19_tri_o_8[8] shield_dp0_dp19_tri_o_7[7] shield_dp0_dp19_tri_o_6[6] shield_dp0_dp19_tri_o_5[5] shield_dp0_dp19_tri_o_4[4] shield_dp0_dp19_tri_o_3[3] shield_dp0_dp19_tri_o_2[2] shield_dp0_dp19_tri_o_1[1] shield_dp0_dp19_tri_o_0[0] -autobundled
netbloc @shield_dp0_dp19_tri_o_19 1 0 3 20 3390 640J 3650 1620
load netBundle @shield_dp0_dp19_tri_t_19 20 shield_dp0_dp19_tri_t_19[19] shield_dp0_dp19_tri_t_18[18] shield_dp0_dp19_tri_t_17[17] shield_dp0_dp19_tri_t_16[16] shield_dp0_dp19_tri_t_15[15] shield_dp0_dp19_tri_t_14[14] shield_dp0_dp19_tri_t_13[13] shield_dp0_dp19_tri_t_12[12] shield_dp0_dp19_tri_t_11[11] shield_dp0_dp19_tri_t_10[10] shield_dp0_dp19_tri_t_9[9] shield_dp0_dp19_tri_t_8[8] shield_dp0_dp19_tri_t_7[7] shield_dp0_dp19_tri_t_6[6] shield_dp0_dp19_tri_t_5[5] shield_dp0_dp19_tri_t_4[4] shield_dp0_dp19_tri_t_3[3] shield_dp0_dp19_tri_t_2[2] shield_dp0_dp19_tri_t_1[1] shield_dp0_dp19_tri_t_0[0] -autobundled
netbloc @shield_dp0_dp19_tri_t_19 1 0 3 60 3410 600J 3670 1340
load netBundle @shield_dp26_dp41_tri_o_15 16 shield_dp26_dp41_tri_o_15[15] shield_dp26_dp41_tri_o_14[14] shield_dp26_dp41_tri_o_13[13] shield_dp26_dp41_tri_o_12[12] shield_dp26_dp41_tri_o_11[11] shield_dp26_dp41_tri_o_10[10] shield_dp26_dp41_tri_o_9[9] shield_dp26_dp41_tri_o_8[8] shield_dp26_dp41_tri_o_7[7] shield_dp26_dp41_tri_o_6[6] shield_dp26_dp41_tri_o_5[5] shield_dp26_dp41_tri_o_4[4] shield_dp26_dp41_tri_o_3[3] shield_dp26_dp41_tri_o_2[2] shield_dp26_dp41_tri_o_1[1] shield_dp26_dp41_tri_o_0[0] -autobundled
netbloc @shield_dp26_dp41_tri_o_15 1 0 3 20 4290 NJ 4290 1640
load netBundle @shield_dp26_dp41_tri_t_15 16 shield_dp26_dp41_tri_t_15[15] shield_dp26_dp41_tri_t_14[14] shield_dp26_dp41_tri_t_13[13] shield_dp26_dp41_tri_t_12[12] shield_dp26_dp41_tri_t_11[11] shield_dp26_dp41_tri_t_10[10] shield_dp26_dp41_tri_t_9[9] shield_dp26_dp41_tri_t_8[8] shield_dp26_dp41_tri_t_7[7] shield_dp26_dp41_tri_t_6[6] shield_dp26_dp41_tri_t_5[5] shield_dp26_dp41_tri_t_4[4] shield_dp26_dp41_tri_t_3[3] shield_dp26_dp41_tri_t_2[2] shield_dp26_dp41_tri_t_1[1] shield_dp26_dp41_tri_t_0[0] -autobundled
netbloc @shield_dp26_dp41_tri_t_15 1 0 3 40 4310 NJ 4310 1600
load netBundle @shield_dp0_dp19_tri_i 20 shield_dp0_dp19_tri_i[19] shield_dp0_dp19_tri_i[18] shield_dp0_dp19_tri_i[17] shield_dp0_dp19_tri_i[16] shield_dp0_dp19_tri_i[15] shield_dp0_dp19_tri_i[14] shield_dp0_dp19_tri_i[13] shield_dp0_dp19_tri_i[12] shield_dp0_dp19_tri_i[11] shield_dp0_dp19_tri_i[10] shield_dp0_dp19_tri_i[9] shield_dp0_dp19_tri_i[8] shield_dp0_dp19_tri_i[7] shield_dp0_dp19_tri_i[6] shield_dp0_dp19_tri_i[5] shield_dp0_dp19_tri_i[4] shield_dp0_dp19_tri_i[3] shield_dp0_dp19_tri_i[2] shield_dp0_dp19_tri_i[1] shield_dp0_dp19_tri_i[0] -autobundled
netbloc @shield_dp0_dp19_tri_i 1 1 1 780 80n
load netBundle @shield_dp26_dp41_tri_i 16 shield_dp26_dp41_tri_i[15] shield_dp26_dp41_tri_i[14] shield_dp26_dp41_tri_i[13] shield_dp26_dp41_tri_i[12] shield_dp26_dp41_tri_i[11] shield_dp26_dp41_tri_i[10] shield_dp26_dp41_tri_i[9] shield_dp26_dp41_tri_i[8] shield_dp26_dp41_tri_i[7] shield_dp26_dp41_tri_i[6] shield_dp26_dp41_tri_i[5] shield_dp26_dp41_tri_i[4] shield_dp26_dp41_tri_i[3] shield_dp26_dp41_tri_i[2] shield_dp26_dp41_tri_i[1] shield_dp26_dp41_tri_i[0] -autobundled
netbloc @shield_dp26_dp41_tri_i 1 1 1 780 3370n
levelinfo -pg 1 0 280 1010 1740
pagesize -pg 1 -db -bbox -sgen -240 0 1990 6380
show
fullfit
#
# initialize ictrl to current module mbv_system_wrapper work:mbv_system_wrapper:NOFILE
ictrl init topinfo |

#include "xwdttb.h"

XWdtTb_Config XWdtTb_ConfigTable[] __attribute__ ((section (".drvcfg_sec"))) = {

	{
		"xlnx,axi-timebase-wdt-3.0", /* compatible */
		0x41a00000, /* reg */
		0x1, /* xlnx,enable-window-wdt */
		0x20, /* xlnx,max-count-width */
		0x8, /* xlnx,sst-count-width */
		0x0, /* xlnx,wdt-clk-freq-hz */
		{0x2001,  0xffff,  0xffff,  0xffff}, /* interrupts */
		0x41200001 /* interrupt-parent */
	},
	 {
		 NULL
	}
};
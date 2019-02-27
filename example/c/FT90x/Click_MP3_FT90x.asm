_mp3_setVolume:
;Click_MP3_FT90x.c,47 :: 		void mp3_setVolume(uint8_t volumeLeft, uint8_t volumeRight)
; volumeRight start address is: 4 (R1)
; volumeLeft start address is: 0 (R0)
; volumeRight end address is: 4 (R1)
; volumeLeft end address is: 0 (R0)
; volumeLeft start address is: 0 (R0)
; volumeRight start address is: 4 (R1)
;Click_MP3_FT90x.c,50 :: 		volume = ( volumeLeft << 8 ) + volumeRight;
BEXTU.L	R2, R0, #256
; volumeLeft end address is: 0 (R0)
ASHL.L	R2, R2, #8
BEXTU.L	R2, R2, #0
ADD.L	R2, R2, R1
; volumeRight end address is: 4 (R1)
;Click_MP3_FT90x.c,51 :: 		mp3_cmdWrite(_MP3_VOL_ADDR, volume);
BEXTU.L	R1, R2, #0
LDK.L	R0, __MP3_VOL_ADDR
CALL	_mp3_cmdWrite+0
;Click_MP3_FT90x.c,52 :: 		}
L_end_mp3_setVolume:
RETURN	
; end of _mp3_setVolume
_systemInit:
;Click_MP3_FT90x.c,54 :: 		void systemInit()
;Click_MP3_FT90x.c,56 :: 		mikrobus_gpioInit( _MIKROBUS1, _MIKROBUS_AN_PIN, _GPIO_INPUT );
LDK.L	R2, #1
LDK.L	R1, #0
LDK.L	R0, #0
CALL	_mikrobus_gpioInit+0
;Click_MP3_FT90x.c,57 :: 		mikrobus_gpioInit( _MIKROBUS1, _MIKROBUS_RST_PIN, _GPIO_OUTPUT );
LDK.L	R2, #0
LDK.L	R1, #1
LDK.L	R0, #0
CALL	_mikrobus_gpioInit+0
;Click_MP3_FT90x.c,58 :: 		mikrobus_gpioInit( _MIKROBUS1, _MIKROBUS_CS_PIN, _GPIO_OUTPUT );
LDK.L	R2, #0
LDK.L	R1, #2
LDK.L	R0, #0
CALL	_mikrobus_gpioInit+0
;Click_MP3_FT90x.c,59 :: 		mikrobus_gpioInit( _MIKROBUS1, _MIKROBUS_INT_PIN, _GPIO_OUTPUT );
LDK.L	R2, #0
LDK.L	R1, #7
LDK.L	R0, #0
CALL	_mikrobus_gpioInit+0
;Click_MP3_FT90x.c,61 :: 		mikrobus_spiInit( _MIKROBUS1, &_MP3_SPI_CFG[0] );
LDK.L	R0, #__MP3_SPI_CFG+0
MOVE.L	R1, R0
LDK.L	R0, #0
CALL	_mikrobus_spiInit+0
;Click_MP3_FT90x.c,62 :: 		mikrobus_logInit( _LOG_USBUART, 9600 );
LDK.L	R1, #9600
LDK.L	R0, #16
CALL	_mikrobus_logInit+0
;Click_MP3_FT90x.c,63 :: 		Delay_ms( 100 );
LPM.L	R28, #3333331
NOP	
L_systemInit0:
SUB.L	R28, R28, #1
CMP.L	R28, #0
JMPC	R30, Z, #0, L_systemInit0
JMP	$+8
	#3333331
NOP	
NOP	
;Click_MP3_FT90x.c,64 :: 		}
L_end_systemInit:
RETURN	
; end of _systemInit
_applicationInit:
;Click_MP3_FT90x.c,66 :: 		void applicationInit()
;Click_MP3_FT90x.c,68 :: 		mp3_spiDriverInit( (T_MP3_P)&_MIKROBUS1_GPIO, (T_MP3_P)&_MIKROBUS1_SPI );
LDK.L	R1, #__MIKROBUS1_SPI+0
LDK.L	R0, #__MIKROBUS1_GPIO+0
CALL	_mp3_spiDriverInit+0
;Click_MP3_FT90x.c,69 :: 		mp3_init();
CALL	_mp3_init+0
;Click_MP3_FT90x.c,70 :: 		mp3_reset();
CALL	_mp3_reset+0
;Click_MP3_FT90x.c,73 :: 		mp3_cmdWrite(_MP3_MODE_ADDR, 0x0800);
LDK.L	R1, #2048
LDK.L	R0, __MP3_MODE_ADDR
CALL	_mp3_cmdWrite+0
;Click_MP3_FT90x.c,74 :: 		mp3_cmdWrite(_MP3_BASS_ADDR, 0x7A00);
LDK.L	R1, #31232
LDK.L	R0, __MP3_BASS_ADDR
CALL	_mp3_cmdWrite+0
;Click_MP3_FT90x.c,75 :: 		mp3_cmdWrite(_MP3_CLOCKF_ADDR, 0x2000);
LDK.L	R1, #8192
LDK.L	R0, __MP3_CLOCKF_ADDR
CALL	_mp3_cmdWrite+0
;Click_MP3_FT90x.c,78 :: 		mp3_setVolume( 0x2F, 0x2F );
LDK.L	R1, #47
LDK.L	R0, #47
CALL	_mp3_setVolume+0
;Click_MP3_FT90x.c,81 :: 		Mmc_Set_Interface(_MMC_INTERFACE_SDHOST);
LDK.L	R0, #1
CALL	_Mmc_Set_Interface+0
;Click_MP3_FT90x.c,82 :: 		SDHost_Init(32, _SDHOST_CFG_4_WIDE_BUS_MODE | _SDHOST_CFG_CLOCK_FALING_EDGE);
LDK.L	R1, #10
LDK.L	R0, #32
CALL	_SDHost_Init+0
;Click_MP3_FT90x.c,84 :: 		mikrobus_logWrite(" --- MMC FAT initialized",_LOG_LINE);
LDK.L	R0, #?lstr1_Click_MP3_FT90x+0
LDK.L	R1, #2
CALL	_mikrobus_logWrite+0
;Click_MP3_FT90x.c,85 :: 		while ( Mmc_Fat_Init());
L_applicationInit2:
CALL	_Mmc_Fat_Init+0
CMP.B	R0, #0
JMPC	R30, Z, #1, L_applicationInit3
JMP	L_applicationInit2
L_applicationInit3:
;Click_MP3_FT90x.c,86 :: 		while ( !Mmc_Fat_Assign(&mp3_filename[0], 0));
L_applicationInit4:
LDK.L	R1, #0
LDK.L	R0, #_mp3_filename+0
CALL	_Mmc_Fat_Assign+0
CMP.B	R0, #0
JMPC	R30, Z, #0, L_applicationInit5
JMP	L_applicationInit4
L_applicationInit5:
;Click_MP3_FT90x.c,87 :: 		}
L_end_applicationInit:
RETURN	
; end of _applicationInit
_applicationTask:
;Click_MP3_FT90x.c,89 :: 		void applicationTask()
;Click_MP3_FT90x.c,91 :: 		Mmc_Fat_Reset(&file_size);
LDK.L	R0, #_file_size+0
CALL	_Mmc_Fat_Reset+0
;Click_MP3_FT90x.c,92 :: 		mikrobus_logWrite(" --- Play audio.",_LOG_LINE);
LDK.L	R0, #?lstr2_Click_MP3_FT90x+0
LDK.L	R1, #2
CALL	_mikrobus_logWrite+0
;Click_MP3_FT90x.c,93 :: 		while (file_size > BUFFER_SIZE)
L_applicationTask6:
LDA.L	R1, _file_size+0
LDK.L	R0, #512
CMP.L	R1, R0
JMPC	R30, A, #0, L_applicationTask7
;Click_MP3_FT90x.c,95 :: 		for (cnt = 0; cnt < BUFFER_SIZE; cnt++)
LDK.L	R0, #0
STA.S	_cnt+0, R0
L_applicationTask8:
LDA.S	R1, _cnt+0
LDK.L	R0, #512
CMP.S	R1, R0
JMPC	R30, C, #0, L_applicationTask9
;Click_MP3_FT90x.c,97 :: 		Mmc_Fat_Read(mp3_buffer + cnt);
LDA.S	R1, _cnt+0
LDK.L	R0, #_mp3_buffer+0
ADD.L	R0, R0, R1
CALL	_Mmc_Fat_Read+0
;Click_MP3_FT90x.c,95 :: 		for (cnt = 0; cnt < BUFFER_SIZE; cnt++)
LDA.S	R0, _cnt+0
ADD.L	R0, R0, #1
STA.S	_cnt+0, R0
;Click_MP3_FT90x.c,98 :: 		}
JMP	L_applicationTask8
L_applicationTask9:
;Click_MP3_FT90x.c,99 :: 		for (cnt = 0; cnt < BUFFER_SIZE / BYTES_2_WRITE; cnt++)
LDK.L	R0, #0
STA.S	_cnt+0, R0
L_applicationTask11:
LDA.S	R0, _cnt+0
CMP.S	R0, #16
JMPC	R30, C, #0, L_applicationTask12
;Click_MP3_FT90x.c,101 :: 		while( mp3_dataWrite32( mp3_buffer + cnt * BYTES_2_WRITE ));
L_applicationTask14:
LDA.S	R0, _cnt+0
ASHL.L	R1, R0, #5
BEXTU.L	R1, R1, #0
LDK.L	R0, #_mp3_buffer+0
ADD.L	R0, R0, R1
CALL	_mp3_dataWrite32+0
CMP.B	R0, #0
JMPC	R30, Z, #1, L_applicationTask15
JMP	L_applicationTask14
L_applicationTask15:
;Click_MP3_FT90x.c,99 :: 		for (cnt = 0; cnt < BUFFER_SIZE / BYTES_2_WRITE; cnt++)
LDA.S	R0, _cnt+0
ADD.L	R0, R0, #1
STA.S	_cnt+0, R0
;Click_MP3_FT90x.c,102 :: 		}
JMP	L_applicationTask11
L_applicationTask12:
;Click_MP3_FT90x.c,103 :: 		file_size -= BUFFER_SIZE;
LDA.L	R1, _file_size+0
LDK.L	R0, #512
SUB.L	R0, R1, R0
STA.L	_file_size+0, R0
;Click_MP3_FT90x.c,104 :: 		}
JMP	L_applicationTask6
L_applicationTask7:
;Click_MP3_FT90x.c,105 :: 		for (cnt = 0; cnt < file_size; cnt++)
LDK.L	R0, #0
STA.S	_cnt+0, R0
L_applicationTask16:
LDA.L	R1, _file_size+0
LDA.S	R0, _cnt+0
CMP.L	R0, R1
JMPC	R30, C, #0, L_applicationTask17
;Click_MP3_FT90x.c,107 :: 		Mmc_Fat_Read(mp3_buffer + cnt);
LDA.S	R1, _cnt+0
LDK.L	R0, #_mp3_buffer+0
ADD.L	R0, R0, R1
CALL	_Mmc_Fat_Read+0
;Click_MP3_FT90x.c,105 :: 		for (cnt = 0; cnt < file_size; cnt++)
LDA.S	R0, _cnt+0
ADD.L	R0, R0, #1
STA.S	_cnt+0, R0
;Click_MP3_FT90x.c,108 :: 		}
JMP	L_applicationTask16
L_applicationTask17:
;Click_MP3_FT90x.c,109 :: 		for (cnt = 0; cnt < file_size; cnt++)
LDK.L	R0, #0
STA.S	_cnt+0, R0
L_applicationTask19:
LDA.L	R1, _file_size+0
LDA.S	R0, _cnt+0
CMP.L	R0, R1
JMPC	R30, C, #0, L_applicationTask20
;Click_MP3_FT90x.c,111 :: 		while( mp3_dataWrite(mp3_buffer + cnt));
L_applicationTask22:
LDA.S	R1, _cnt+0
LDK.L	R0, #_mp3_buffer+0
ADD.L	R0, R0, R1
BEXTU.L	R0, R0, #256
CALL	_mp3_dataWrite+0
CMP.B	R0, #0
JMPC	R30, Z, #1, L_applicationTask23
JMP	L_applicationTask22
L_applicationTask23:
;Click_MP3_FT90x.c,109 :: 		for (cnt = 0; cnt < file_size; cnt++)
LDA.S	R0, _cnt+0
ADD.L	R0, R0, #1
STA.S	_cnt+0, R0
;Click_MP3_FT90x.c,112 :: 		}
JMP	L_applicationTask19
L_applicationTask20:
;Click_MP3_FT90x.c,113 :: 		mikrobus_logWrite(" --- Finish! ",_LOG_LINE);
LDK.L	R0, #?lstr3_Click_MP3_FT90x+0
LDK.L	R1, #2
CALL	_mikrobus_logWrite+0
;Click_MP3_FT90x.c,114 :: 		Delay_100ms();
CALL	_Delay_100ms+0
;Click_MP3_FT90x.c,115 :: 		}
L_end_applicationTask:
RETURN	
; end of _applicationTask
_main:
;Click_MP3_FT90x.c,117 :: 		void main()
LDK.L	SP, #43605
;Click_MP3_FT90x.c,119 :: 		systemInit();
CALL	_systemInit+0
;Click_MP3_FT90x.c,120 :: 		applicationInit();
CALL	_applicationInit+0
;Click_MP3_FT90x.c,122 :: 		while (1)
L_main24:
;Click_MP3_FT90x.c,124 :: 		applicationTask();
CALL	_applicationTask+0
;Click_MP3_FT90x.c,125 :: 		}
JMP	L_main24
;Click_MP3_FT90x.c,126 :: 		}
L_end_main:
L__main_end_loop:
JMP	L__main_end_loop
; end of _main

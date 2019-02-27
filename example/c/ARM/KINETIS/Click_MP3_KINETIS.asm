_mp3_setVolume:
;Click_MP3_KINETIS.c,47 :: 		void mp3_setVolume(uint8_t volumeLeft, uint8_t volumeRight)
; volumeRight start address is: 4 (R1)
; volumeLeft start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
; volumeRight end address is: 4 (R1)
; volumeLeft end address is: 0 (R0)
; volumeLeft start address is: 0 (R0)
; volumeRight start address is: 4 (R1)
;Click_MP3_KINETIS.c,50 :: 		volume = ( volumeLeft << 8 ) + volumeRight;
LSLS	R2, R0, #8
UXTH	R2, R2
; volumeLeft end address is: 0 (R0)
ADDS	R2, R2, R1
; volumeRight end address is: 4 (R1)
;Click_MP3_KINETIS.c,51 :: 		mp3_cmdWrite(_MP3_VOL_ADDR, volume);
UXTH	R1, R2
MOVS	R0, __MP3_VOL_ADDR
BL	_mp3_cmdWrite+0
;Click_MP3_KINETIS.c,52 :: 		}
L_end_mp3_setVolume:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _mp3_setVolume
_systemInit:
;Click_MP3_KINETIS.c,54 :: 		void systemInit()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Click_MP3_KINETIS.c,56 :: 		mikrobus_gpioInit( _MIKROBUS1, _MIKROBUS_AN_PIN, _GPIO_INPUT );
MOVS	R2, #1
MOVS	R1, #0
MOVS	R0, #0
BL	_mikrobus_gpioInit+0
;Click_MP3_KINETIS.c,57 :: 		mikrobus_gpioInit( _MIKROBUS1, _MIKROBUS_RST_PIN, _GPIO_OUTPUT );
MOVS	R2, #0
MOVS	R1, #1
MOVS	R0, #0
BL	_mikrobus_gpioInit+0
;Click_MP3_KINETIS.c,58 :: 		mikrobus_gpioInit( _MIKROBUS1, _MIKROBUS_CS_PIN, _GPIO_OUTPUT );
MOVS	R2, #0
MOVS	R1, #2
MOVS	R0, #0
BL	_mikrobus_gpioInit+0
;Click_MP3_KINETIS.c,59 :: 		mikrobus_gpioInit( _MIKROBUS1, _MIKROBUS_INT_PIN, _GPIO_OUTPUT );
MOVS	R2, #0
MOVS	R1, #7
MOVS	R0, #0
BL	_mikrobus_gpioInit+0
;Click_MP3_KINETIS.c,61 :: 		mikrobus_spiInit( _MIKROBUS1, &_MP3_SPI_CFG[0] );
MOVW	R0, #lo_addr(__MP3_SPI_CFG+0)
MOVT	R0, #hi_addr(__MP3_SPI_CFG+0)
MOV	R1, R0
MOVS	R0, #0
BL	_mikrobus_spiInit+0
;Click_MP3_KINETIS.c,62 :: 		mikrobus_logInit( _MIKROBUS2, 9600 );
MOVW	R1, #9600
MOVS	R0, #1
BL	_mikrobus_logInit+0
;Click_MP3_KINETIS.c,63 :: 		Delay_ms( 100 );
MOVW	R7, #2302
MOVT	R7, #61
NOP
NOP
L_systemInit0:
SUBS	R7, R7, #1
BNE	L_systemInit0
NOP
NOP
NOP
;Click_MP3_KINETIS.c,64 :: 		}
L_end_systemInit:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _systemInit
_applicationInit:
;Click_MP3_KINETIS.c,66 :: 		void applicationInit()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Click_MP3_KINETIS.c,68 :: 		mp3_spiDriverInit( (T_MP3_P)&_MIKROBUS1_GPIO, (T_MP3_P)&_MIKROBUS1_SPI );
MOVW	R1, #lo_addr(__MIKROBUS1_SPI+0)
MOVT	R1, #hi_addr(__MIKROBUS1_SPI+0)
MOVW	R0, #lo_addr(__MIKROBUS1_GPIO+0)
MOVT	R0, #hi_addr(__MIKROBUS1_GPIO+0)
BL	_mp3_spiDriverInit+0
;Click_MP3_KINETIS.c,69 :: 		mp3_init();
BL	_mp3_init+0
;Click_MP3_KINETIS.c,70 :: 		mp3_reset();
BL	_mp3_reset+0
;Click_MP3_KINETIS.c,73 :: 		mp3_cmdWrite(_MP3_MODE_ADDR, 0x0800);
MOVW	R1, #2048
MOVS	R0, __MP3_MODE_ADDR
BL	_mp3_cmdWrite+0
;Click_MP3_KINETIS.c,74 :: 		mp3_cmdWrite(_MP3_BASS_ADDR, 0x7A00);
MOVW	R1, #31232
MOVS	R0, __MP3_BASS_ADDR
BL	_mp3_cmdWrite+0
;Click_MP3_KINETIS.c,75 :: 		mp3_cmdWrite(_MP3_CLOCKF_ADDR, 0x2000);
MOVW	R1, #8192
MOVS	R0, __MP3_CLOCKF_ADDR
BL	_mp3_cmdWrite+0
;Click_MP3_KINETIS.c,78 :: 		mp3_setVolume( 0x2F, 0x2F );
MOVS	R1, #47
MOVS	R0, #47
BL	_mp3_setVolume+0
;Click_MP3_KINETIS.c,80 :: 		Mmc_Set_Interface(_MMC_INTERFACE_SDHC);
MOVS	R0, #1
BL	_Mmc_Set_Interface+0
;Click_MP3_KINETIS.c,81 :: 		mikrobus_logWrite(" --- Mmc (FAT) init start",_LOG_LINE);
MOVW	R0, #lo_addr(?lstr1_Click_MP3_KINETIS+0)
MOVT	R0, #hi_addr(?lstr1_Click_MP3_KINETIS+0)
MOVS	R1, #2
BL	_mikrobus_logWrite+0
;Click_MP3_KINETIS.c,82 :: 		while ( Mmc_Fat_Init());
L_applicationInit2:
BL	_Mmc_Fat_Init+0
CMP	R0, #0
IT	EQ
BEQ	L_applicationInit3
IT	AL
BAL	L_applicationInit2
L_applicationInit3:
;Click_MP3_KINETIS.c,83 :: 		while ( !Mmc_Fat_Assign(&mp3_filename[0], 0));
L_applicationInit4:
MOVS	R1, #0
MOVW	R0, #lo_addr(_mp3_filename+0)
MOVT	R0, #hi_addr(_mp3_filename+0)
BL	_Mmc_Fat_Assign+0
CMP	R0, #0
IT	NE
BNE	L_applicationInit5
IT	AL
BAL	L_applicationInit4
L_applicationInit5:
;Click_MP3_KINETIS.c,84 :: 		mikrobus_logWrite(" --- Mmc (FAT) init done",_LOG_LINE);
MOVW	R0, #lo_addr(?lstr2_Click_MP3_KINETIS+0)
MOVT	R0, #hi_addr(?lstr2_Click_MP3_KINETIS+0)
MOVS	R1, #2
BL	_mikrobus_logWrite+0
;Click_MP3_KINETIS.c,85 :: 		}
L_end_applicationInit:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _applicationInit
_applicationTask:
;Click_MP3_KINETIS.c,87 :: 		void applicationTask()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Click_MP3_KINETIS.c,89 :: 		Mmc_Fat_Reset(&file_size);
MOVW	R0, #lo_addr(_file_size+0)
MOVT	R0, #hi_addr(_file_size+0)
BL	_Mmc_Fat_Reset+0
;Click_MP3_KINETIS.c,90 :: 		mikrobus_logWrite(" --- Play audio.",_LOG_LINE);
MOVW	R0, #lo_addr(?lstr3_Click_MP3_KINETIS+0)
MOVT	R0, #hi_addr(?lstr3_Click_MP3_KINETIS+0)
MOVS	R1, #2
BL	_mikrobus_logWrite+0
;Click_MP3_KINETIS.c,91 :: 		while (file_size > BUFFER_SIZE)
L_applicationTask6:
MOVW	R0, #lo_addr(_file_size+0)
MOVT	R0, #hi_addr(_file_size+0)
LDR	R0, [R0, #0]
CMP	R0, #512
IT	LS
BLS	L_applicationTask7
;Click_MP3_KINETIS.c,93 :: 		for (cnt = 0; cnt < BUFFER_SIZE; cnt++)
MOVS	R1, #0
MOVW	R0, #lo_addr(_cnt+0)
MOVT	R0, #hi_addr(_cnt+0)
STRH	R1, [R0, #0]
L_applicationTask8:
MOVW	R0, #lo_addr(_cnt+0)
MOVT	R0, #hi_addr(_cnt+0)
LDRH	R0, [R0, #0]
CMP	R0, #512
IT	CS
BCS	L_applicationTask9
;Click_MP3_KINETIS.c,95 :: 		Mmc_Fat_Read(mp3_buffer + cnt);
MOVW	R0, #lo_addr(_cnt+0)
MOVT	R0, #hi_addr(_cnt+0)
LDRH	R1, [R0, #0]
MOVW	R0, #lo_addr(_mp3_buffer+0)
MOVT	R0, #hi_addr(_mp3_buffer+0)
ADDS	R0, R0, R1
BL	_Mmc_Fat_Read+0
;Click_MP3_KINETIS.c,93 :: 		for (cnt = 0; cnt < BUFFER_SIZE; cnt++)
MOVW	R1, #lo_addr(_cnt+0)
MOVT	R1, #hi_addr(_cnt+0)
LDRH	R0, [R1, #0]
ADDS	R0, R0, #1
STRH	R0, [R1, #0]
;Click_MP3_KINETIS.c,96 :: 		}
IT	AL
BAL	L_applicationTask8
L_applicationTask9:
;Click_MP3_KINETIS.c,97 :: 		for (cnt = 0; cnt < BUFFER_SIZE / BYTES_2_WRITE; cnt++)
MOVS	R1, #0
MOVW	R0, #lo_addr(_cnt+0)
MOVT	R0, #hi_addr(_cnt+0)
STRH	R1, [R0, #0]
L_applicationTask11:
MOVW	R0, #lo_addr(_cnt+0)
MOVT	R0, #hi_addr(_cnt+0)
LDRH	R0, [R0, #0]
CMP	R0, #16
IT	CS
BCS	L_applicationTask12
;Click_MP3_KINETIS.c,99 :: 		while( mp3_dataWrite32( mp3_buffer + cnt * BYTES_2_WRITE ));
L_applicationTask14:
MOVW	R0, #lo_addr(_cnt+0)
MOVT	R0, #hi_addr(_cnt+0)
LDRH	R0, [R0, #0]
LSLS	R1, R0, #5
UXTH	R1, R1
MOVW	R0, #lo_addr(_mp3_buffer+0)
MOVT	R0, #hi_addr(_mp3_buffer+0)
ADDS	R0, R0, R1
BL	_mp3_dataWrite32+0
CMP	R0, #0
IT	EQ
BEQ	L_applicationTask15
IT	AL
BAL	L_applicationTask14
L_applicationTask15:
;Click_MP3_KINETIS.c,97 :: 		for (cnt = 0; cnt < BUFFER_SIZE / BYTES_2_WRITE; cnt++)
MOVW	R1, #lo_addr(_cnt+0)
MOVT	R1, #hi_addr(_cnt+0)
LDRH	R0, [R1, #0]
ADDS	R0, R0, #1
STRH	R0, [R1, #0]
;Click_MP3_KINETIS.c,100 :: 		}
IT	AL
BAL	L_applicationTask11
L_applicationTask12:
;Click_MP3_KINETIS.c,101 :: 		file_size -= BUFFER_SIZE;
MOVW	R1, #lo_addr(_file_size+0)
MOVT	R1, #hi_addr(_file_size+0)
LDR	R0, [R1, #0]
SUB	R0, R0, #512
STR	R0, [R1, #0]
;Click_MP3_KINETIS.c,102 :: 		}
IT	AL
BAL	L_applicationTask6
L_applicationTask7:
;Click_MP3_KINETIS.c,103 :: 		for (cnt = 0; cnt < file_size; cnt++)
MOVS	R1, #0
MOVW	R0, #lo_addr(_cnt+0)
MOVT	R0, #hi_addr(_cnt+0)
STRH	R1, [R0, #0]
L_applicationTask16:
MOVW	R0, #lo_addr(_file_size+0)
MOVT	R0, #hi_addr(_file_size+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_cnt+0)
MOVT	R0, #hi_addr(_cnt+0)
LDRH	R0, [R0, #0]
CMP	R0, R1
IT	CS
BCS	L_applicationTask17
;Click_MP3_KINETIS.c,105 :: 		Mmc_Fat_Read(mp3_buffer + cnt);
MOVW	R0, #lo_addr(_cnt+0)
MOVT	R0, #hi_addr(_cnt+0)
LDRH	R1, [R0, #0]
MOVW	R0, #lo_addr(_mp3_buffer+0)
MOVT	R0, #hi_addr(_mp3_buffer+0)
ADDS	R0, R0, R1
BL	_Mmc_Fat_Read+0
;Click_MP3_KINETIS.c,103 :: 		for (cnt = 0; cnt < file_size; cnt++)
MOVW	R1, #lo_addr(_cnt+0)
MOVT	R1, #hi_addr(_cnt+0)
LDRH	R0, [R1, #0]
ADDS	R0, R0, #1
STRH	R0, [R1, #0]
;Click_MP3_KINETIS.c,106 :: 		}
IT	AL
BAL	L_applicationTask16
L_applicationTask17:
;Click_MP3_KINETIS.c,107 :: 		for (cnt = 0; cnt < file_size; cnt++)
MOVS	R1, #0
MOVW	R0, #lo_addr(_cnt+0)
MOVT	R0, #hi_addr(_cnt+0)
STRH	R1, [R0, #0]
L_applicationTask19:
MOVW	R0, #lo_addr(_file_size+0)
MOVT	R0, #hi_addr(_file_size+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_cnt+0)
MOVT	R0, #hi_addr(_cnt+0)
LDRH	R0, [R0, #0]
CMP	R0, R1
IT	CS
BCS	L_applicationTask20
;Click_MP3_KINETIS.c,109 :: 		while( mp3_dataWrite(mp3_buffer + cnt));
L_applicationTask22:
MOVW	R0, #lo_addr(_cnt+0)
MOVT	R0, #hi_addr(_cnt+0)
LDRH	R1, [R0, #0]
MOVW	R0, #lo_addr(_mp3_buffer+0)
MOVT	R0, #hi_addr(_mp3_buffer+0)
ADDS	R0, R0, R1
UXTB	R0, R0
BL	_mp3_dataWrite+0
CMP	R0, #0
IT	EQ
BEQ	L_applicationTask23
IT	AL
BAL	L_applicationTask22
L_applicationTask23:
;Click_MP3_KINETIS.c,107 :: 		for (cnt = 0; cnt < file_size; cnt++)
MOVW	R1, #lo_addr(_cnt+0)
MOVT	R1, #hi_addr(_cnt+0)
LDRH	R0, [R1, #0]
ADDS	R0, R0, #1
STRH	R0, [R1, #0]
;Click_MP3_KINETIS.c,110 :: 		}
IT	AL
BAL	L_applicationTask19
L_applicationTask20:
;Click_MP3_KINETIS.c,111 :: 		mikrobus_logWrite(" --- Finish! ",_LOG_LINE);
MOVW	R0, #lo_addr(?lstr4_Click_MP3_KINETIS+0)
MOVT	R0, #hi_addr(?lstr4_Click_MP3_KINETIS+0)
MOVS	R1, #2
BL	_mikrobus_logWrite+0
;Click_MP3_KINETIS.c,112 :: 		Delay_100ms();
BL	_Delay_100ms+0
;Click_MP3_KINETIS.c,113 :: 		}
L_end_applicationTask:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _applicationTask
_main:
;Click_MP3_KINETIS.c,115 :: 		void main()
;Click_MP3_KINETIS.c,117 :: 		systemInit();
BL	_systemInit+0
;Click_MP3_KINETIS.c,118 :: 		applicationInit();
BL	_applicationInit+0
;Click_MP3_KINETIS.c,120 :: 		while (1)
L_main24:
;Click_MP3_KINETIS.c,122 :: 		applicationTask();
BL	_applicationTask+0
;Click_MP3_KINETIS.c,123 :: 		}
IT	AL
BAL	L_main24
;Click_MP3_KINETIS.c,124 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main

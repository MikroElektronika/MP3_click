_mp3_setVolume:
;Click_MP3_PIC32.c,49 :: 		void mp3_setVolume(uint8_t volumeLeft, uint8_t volumeRight)
ADDIU	SP, SP, -12
SW	RA, 0(SP)
;Click_MP3_PIC32.c,52 :: 		volume = ( volumeLeft << 8 ) + volumeRight;
SW	R25, 4(SP)
SW	R26, 8(SP)
ANDI	R2, R25, 255
SLL	R3, R2, 8
ANDI	R2, R26, 255
ADDU	R2, R3, R2
;Click_MP3_PIC32.c,53 :: 		mp3_cmdWrite(_MP3_VOL_ADDR, volume);
ANDI	R26, R2, 65535
ORI	R25, R0, __MP3_VOL_ADDR
JAL	_mp3_cmdWrite+0
NOP	
;Click_MP3_PIC32.c,54 :: 		}
L_end_mp3_setVolume:
LW	R26, 8(SP)
LW	R25, 4(SP)
LW	RA, 0(SP)
ADDIU	SP, SP, 12
JR	RA
NOP	
; end of _mp3_setVolume
_systemInit:
;Click_MP3_PIC32.c,56 :: 		void systemInit()
ADDIU	SP, SP, -16
SW	RA, 0(SP)
;Click_MP3_PIC32.c,58 :: 		mikrobus_gpioInit( _MIKROBUS1, _MIKROBUS_AN_PIN, _GPIO_INPUT );
SW	R25, 4(SP)
SW	R26, 8(SP)
SW	R27, 12(SP)
ORI	R27, R0, 1
MOVZ	R26, R0, R0
MOVZ	R25, R0, R0
JAL	_mikrobus_gpioInit+0
NOP	
;Click_MP3_PIC32.c,59 :: 		mikrobus_gpioInit( _MIKROBUS1, _MIKROBUS_RST_PIN, _GPIO_OUTPUT );
MOVZ	R27, R0, R0
ORI	R26, R0, 1
MOVZ	R25, R0, R0
JAL	_mikrobus_gpioInit+0
NOP	
;Click_MP3_PIC32.c,60 :: 		mikrobus_gpioInit( _MIKROBUS1, _MIKROBUS_CS_PIN, _GPIO_OUTPUT );
MOVZ	R27, R0, R0
ORI	R26, R0, 2
MOVZ	R25, R0, R0
JAL	_mikrobus_gpioInit+0
NOP	
;Click_MP3_PIC32.c,61 :: 		mikrobus_gpioInit( _MIKROBUS1, _MIKROBUS_INT_PIN, _GPIO_OUTPUT );
MOVZ	R27, R0, R0
ORI	R26, R0, 7
MOVZ	R25, R0, R0
JAL	_mikrobus_gpioInit+0
NOP	
;Click_MP3_PIC32.c,62 :: 		AD1PCFG = 0xFFFF;
ORI	R2, R0, 65535
SW	R2, Offset(AD1PCFG+0)(GP)
;Click_MP3_PIC32.c,63 :: 		mikrobus_spiInit( _MIKROBUS1, &_MP3_SPI_CFG[0] );
LUI	R2, hi_addr(__MP3_SPI_CFG+0)
ORI	R2, R2, lo_addr(__MP3_SPI_CFG+0)
MOVZ	R26, R2, R0
MOVZ	R25, R0, R0
JAL	_mikrobus_spiInit+0
NOP	
;Click_MP3_PIC32.c,64 :: 		mikrobus_logInit( _LOG_USBUART_A, 9600 );
ORI	R26, R0, 9600
ORI	R25, R0, 32
JAL	_mikrobus_logInit+0
NOP	
;Click_MP3_PIC32.c,65 :: 		Delay_ms( 100 );
LUI	R24, 40
ORI	R24, R24, 45226
L_systemInit0:
ADDIU	R24, R24, -1
BNE	R24, R0, L_systemInit0
NOP	
;Click_MP3_PIC32.c,66 :: 		}
L_end_systemInit:
LW	R27, 12(SP)
LW	R26, 8(SP)
LW	R25, 4(SP)
LW	RA, 0(SP)
ADDIU	SP, SP, 16
JR	RA
NOP	
; end of _systemInit
_applicationInit:
;Click_MP3_PIC32.c,68 :: 		void applicationInit()
ADDIU	SP, SP, -12
SW	RA, 0(SP)
;Click_MP3_PIC32.c,70 :: 		mp3_spiDriverInit( (T_MP3_P)&_MIKROBUS1_GPIO, (T_MP3_P)&_MIKROBUS1_SPI );
SW	R25, 4(SP)
SW	R26, 8(SP)
LUI	R26, hi_addr(__MIKROBUS1_SPI+0)
ORI	R26, R26, lo_addr(__MIKROBUS1_SPI+0)
LUI	R25, hi_addr(__MIKROBUS1_GPIO+0)
ORI	R25, R25, lo_addr(__MIKROBUS1_GPIO+0)
JAL	_mp3_spiDriverInit+0
NOP	
;Click_MP3_PIC32.c,71 :: 		mp3_init();
JAL	_mp3_init+0
NOP	
;Click_MP3_PIC32.c,72 :: 		mp3_reset();
JAL	_mp3_reset+0
NOP	
;Click_MP3_PIC32.c,75 :: 		mp3_cmdWrite(_MP3_MODE_ADDR, 0x0800);
ORI	R26, R0, 2048
ORI	R25, R0, __MP3_MODE_ADDR
JAL	_mp3_cmdWrite+0
NOP	
;Click_MP3_PIC32.c,76 :: 		mp3_cmdWrite(_MP3_BASS_ADDR, 0x7A00);
ORI	R26, R0, 31232
ORI	R25, R0, __MP3_BASS_ADDR
JAL	_mp3_cmdWrite+0
NOP	
;Click_MP3_PIC32.c,77 :: 		mp3_cmdWrite(_MP3_CLOCKF_ADDR, 0x2000);
ORI	R26, R0, 8192
ORI	R25, R0, __MP3_CLOCKF_ADDR
JAL	_mp3_cmdWrite+0
NOP	
;Click_MP3_PIC32.c,80 :: 		mp3_setVolume( 0x2F, 0x2F );
ORI	R26, R0, 47
ORI	R25, R0, 47
JAL	_mp3_setVolume+0
NOP	
;Click_MP3_PIC32.c,82 :: 		mikrobus_logWrite(" --- MMC FAT initialized",_LOG_LINE);
ORI	R26, R0, 2
LUI	R25, hi_addr(?lstr1_Click_MP3_PIC32+0)
ORI	R25, R25, lo_addr(?lstr1_Click_MP3_PIC32+0)
JAL	_mikrobus_logWrite+0
NOP	
;Click_MP3_PIC32.c,83 :: 		while ( Mmc_Fat_Init());
L_applicationInit2:
JAL	_Mmc_Fat_Init+0
NOP	
BNE	R2, R0, L__applicationInit30
NOP	
J	L_applicationInit3
NOP	
L__applicationInit30:
J	L_applicationInit2
NOP	
L_applicationInit3:
;Click_MP3_PIC32.c,84 :: 		while ( !Mmc_Fat_Assign(&mp3_filename[0], 0));
L_applicationInit4:
MOVZ	R26, R0, R0
LUI	R25, hi_addr(_mp3_filename+0)
ORI	R25, R25, lo_addr(_mp3_filename+0)
JAL	_Mmc_Fat_Assign+0
NOP	
BEQ	R2, R0, L__applicationInit31
NOP	
J	L_applicationInit5
NOP	
L__applicationInit31:
J	L_applicationInit4
NOP	
L_applicationInit5:
;Click_MP3_PIC32.c,85 :: 		}
L_end_applicationInit:
LW	R26, 8(SP)
LW	R25, 4(SP)
LW	RA, 0(SP)
ADDIU	SP, SP, 12
JR	RA
NOP	
; end of _applicationInit
_applicationTask:
;Click_MP3_PIC32.c,87 :: 		void applicationTask()
ADDIU	SP, SP, -12
SW	RA, 0(SP)
;Click_MP3_PIC32.c,89 :: 		Mmc_Fat_Reset(&file_size);
SW	R25, 4(SP)
SW	R26, 8(SP)
LUI	R25, hi_addr(_file_size+0)
ORI	R25, R25, lo_addr(_file_size+0)
JAL	_Mmc_Fat_Reset+0
NOP	
;Click_MP3_PIC32.c,90 :: 		mikrobus_logWrite(" --- Play audio.",_LOG_LINE);
ORI	R26, R0, 2
LUI	R25, hi_addr(?lstr2_Click_MP3_PIC32+0)
ORI	R25, R25, lo_addr(?lstr2_Click_MP3_PIC32+0)
JAL	_mikrobus_logWrite+0
NOP	
;Click_MP3_PIC32.c,91 :: 		while (file_size > BUFFER_SIZE)
L_applicationTask6:
LW	R2, Offset(_file_size+0)(GP)
SLTIU	R2, R2, 513
BEQ	R2, R0, L__applicationTask33
NOP	
J	L_applicationTask7
NOP	
L__applicationTask33:
;Click_MP3_PIC32.c,93 :: 		for (cnt = 0; cnt < BUFFER_SIZE; cnt++)
SH	R0, Offset(_cnt+0)(GP)
L_applicationTask8:
LHU	R2, Offset(_cnt+0)(GP)
SLTIU	R2, R2, 512
BNE	R2, R0, L__applicationTask34
NOP	
J	L_applicationTask9
NOP	
L__applicationTask34:
;Click_MP3_PIC32.c,95 :: 		Mmc_Fat_Read(mp3_buffer + cnt);
LHU	R3, Offset(_cnt+0)(GP)
LUI	R2, hi_addr(_mp3_buffer+0)
ORI	R2, R2, lo_addr(_mp3_buffer+0)
ADDU	R2, R2, R3
MOVZ	R25, R2, R0
JAL	_Mmc_Fat_Read+0
NOP	
;Click_MP3_PIC32.c,93 :: 		for (cnt = 0; cnt < BUFFER_SIZE; cnt++)
LHU	R2, Offset(_cnt+0)(GP)
ADDIU	R2, R2, 1
SH	R2, Offset(_cnt+0)(GP)
;Click_MP3_PIC32.c,96 :: 		}
J	L_applicationTask8
NOP	
L_applicationTask9:
;Click_MP3_PIC32.c,97 :: 		for (cnt = 0; cnt < BUFFER_SIZE / BYTES_2_WRITE; cnt++)
SH	R0, Offset(_cnt+0)(GP)
L_applicationTask11:
LHU	R2, Offset(_cnt+0)(GP)
SLTIU	R2, R2, 16
BNE	R2, R0, L__applicationTask35
NOP	
J	L_applicationTask12
NOP	
L__applicationTask35:
;Click_MP3_PIC32.c,99 :: 		while( mp3_dataWrite32( mp3_buffer + cnt * BYTES_2_WRITE ));
L_applicationTask14:
LHU	R2, Offset(_cnt+0)(GP)
SLL	R2, R2, 5
ANDI	R3, R2, 65535
LUI	R2, hi_addr(_mp3_buffer+0)
ORI	R2, R2, lo_addr(_mp3_buffer+0)
ADDU	R2, R2, R3
MOVZ	R25, R2, R0
JAL	_mp3_dataWrite32+0
NOP	
BNE	R2, R0, L__applicationTask37
NOP	
J	L_applicationTask15
NOP	
L__applicationTask37:
J	L_applicationTask14
NOP	
L_applicationTask15:
;Click_MP3_PIC32.c,97 :: 		for (cnt = 0; cnt < BUFFER_SIZE / BYTES_2_WRITE; cnt++)
LHU	R2, Offset(_cnt+0)(GP)
ADDIU	R2, R2, 1
SH	R2, Offset(_cnt+0)(GP)
;Click_MP3_PIC32.c,100 :: 		}
J	L_applicationTask11
NOP	
L_applicationTask12:
;Click_MP3_PIC32.c,101 :: 		file_size -= BUFFER_SIZE;
LW	R2, Offset(_file_size+0)(GP)
ADDIU	R2, R2, -512
SW	R2, Offset(_file_size+0)(GP)
;Click_MP3_PIC32.c,102 :: 		}
J	L_applicationTask6
NOP	
L_applicationTask7:
;Click_MP3_PIC32.c,103 :: 		for (cnt = 0; cnt < file_size; cnt++)
SH	R0, Offset(_cnt+0)(GP)
L_applicationTask16:
LW	R3, Offset(_file_size+0)(GP)
LHU	R2, Offset(_cnt+0)(GP)
SLTU	R2, R2, R3
BNE	R2, R0, L__applicationTask38
NOP	
J	L_applicationTask17
NOP	
L__applicationTask38:
;Click_MP3_PIC32.c,105 :: 		Mmc_Fat_Read(mp3_buffer + cnt);
LHU	R3, Offset(_cnt+0)(GP)
LUI	R2, hi_addr(_mp3_buffer+0)
ORI	R2, R2, lo_addr(_mp3_buffer+0)
ADDU	R2, R2, R3
MOVZ	R25, R2, R0
JAL	_Mmc_Fat_Read+0
NOP	
;Click_MP3_PIC32.c,103 :: 		for (cnt = 0; cnt < file_size; cnt++)
LHU	R2, Offset(_cnt+0)(GP)
ADDIU	R2, R2, 1
SH	R2, Offset(_cnt+0)(GP)
;Click_MP3_PIC32.c,106 :: 		}
J	L_applicationTask16
NOP	
L_applicationTask17:
;Click_MP3_PIC32.c,107 :: 		for (cnt = 0; cnt < file_size; cnt++)
SH	R0, Offset(_cnt+0)(GP)
L_applicationTask19:
LW	R3, Offset(_file_size+0)(GP)
LHU	R2, Offset(_cnt+0)(GP)
SLTU	R2, R2, R3
BNE	R2, R0, L__applicationTask39
NOP	
J	L_applicationTask20
NOP	
L__applicationTask39:
;Click_MP3_PIC32.c,109 :: 		while( mp3_dataWrite(mp3_buffer + cnt));
L_applicationTask22:
LHU	R3, Offset(_cnt+0)(GP)
LUI	R2, hi_addr(_mp3_buffer+0)
ORI	R2, R2, lo_addr(_mp3_buffer+0)
ADDU	R2, R2, R3
MOVZ	R25, R2, R0
JAL	_mp3_dataWrite+0
NOP	
BNE	R2, R0, L__applicationTask41
NOP	
J	L_applicationTask23
NOP	
L__applicationTask41:
J	L_applicationTask22
NOP	
L_applicationTask23:
;Click_MP3_PIC32.c,107 :: 		for (cnt = 0; cnt < file_size; cnt++)
LHU	R2, Offset(_cnt+0)(GP)
ADDIU	R2, R2, 1
SH	R2, Offset(_cnt+0)(GP)
;Click_MP3_PIC32.c,110 :: 		}
J	L_applicationTask19
NOP	
L_applicationTask20:
;Click_MP3_PIC32.c,111 :: 		mikrobus_logWrite(" --- Finish! ",_LOG_LINE);
ORI	R26, R0, 2
LUI	R25, hi_addr(?lstr3_Click_MP3_PIC32+0)
ORI	R25, R25, lo_addr(?lstr3_Click_MP3_PIC32+0)
JAL	_mikrobus_logWrite+0
NOP	
;Click_MP3_PIC32.c,112 :: 		Delay_100ms();
JAL	_Delay_100ms+0
NOP	
;Click_MP3_PIC32.c,113 :: 		}
L_end_applicationTask:
LW	R26, 8(SP)
LW	R25, 4(SP)
LW	RA, 0(SP)
ADDIU	SP, SP, 12
JR	RA
NOP	
; end of _applicationTask
_main:
;Click_MP3_PIC32.c,115 :: 		void main()
;Click_MP3_PIC32.c,117 :: 		systemInit();
JAL	_systemInit+0
NOP	
;Click_MP3_PIC32.c,118 :: 		applicationInit();
JAL	_applicationInit+0
NOP	
;Click_MP3_PIC32.c,120 :: 		while (1)
L_main24:
;Click_MP3_PIC32.c,122 :: 		applicationTask();
JAL	_applicationTask+0
NOP	
;Click_MP3_PIC32.c,123 :: 		}
J	L_main24
NOP	
;Click_MP3_PIC32.c,124 :: 		}
L_end_main:
L__main_end_loop:
J	L__main_end_loop
NOP	
; end of _main

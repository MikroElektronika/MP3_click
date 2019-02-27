
_mp3_setVolume:

	PUSH	W10
	PUSH	W11
	ZE	W10, W0
	SL	W0, #8, W1
	ZE	W11, W0
	ADD	W1, W0, W0
	MOV	W0, W11
	MOV.B	#__MP3_VOL_ADDR, W10
	CALL	_mp3_cmdWrite
L_end_mp3_setVolume:
	POP	W11
	POP	W10
	RETURN
; end of _mp3_setVolume

_systemInit:

	PUSH	W10
	PUSH	W11
	PUSH	W12
	MOV	#lo_addr(CLKDIVbits), W0
	MOV.B	[W0], W1
	MOV.B	#224, W0
	AND.B	W1, W0, W1
	MOV	#lo_addr(CLKDIVbits), W0
	MOV.B	W1, [W0]
	MOV	#38, W0
	MOV	WREG, PLLFBD
	MOV	#lo_addr(CLKDIVbits), W0
	MOV.B	[W0], W1
	MOV.B	#63, W0
	AND.B	W1, W0, W1
	MOV	#lo_addr(CLKDIVbits), W0
	MOV.B	W1, [W0]
	MOV	#65535, W0
	MOV	WREG, AD1PCFGL
	MOV	#65535, W0
	MOV	WREG, AD1PCFGH
	MOV.B	#1, W12
	CLR	W11
	CLR	W10
	CALL	_mikrobus_gpioInit
	CLR	W12
	MOV.B	#1, W11
	CLR	W10
	CALL	_mikrobus_gpioInit
	CLR	W12
	MOV.B	#2, W11
	CLR	W10
	CALL	_mikrobus_gpioInit
	CLR	W12
	MOV.B	#7, W11
	CLR	W10
	CALL	_mikrobus_gpioInit
	MOV	#lo_addr(__MP3_SPI_CFG), W0
	MOV	W0, W11
	CLR	W10
	CALL	_mikrobus_spiInit
	MOV	#9600, W11
	MOV	#0, W12
	MOV.B	#48, W10
	CALL	_mikrobus_logInit
	MOV	#21, W8
	MOV	#22619, W7
L_systemInit0:
	DEC	W7
	BRA NZ	L_systemInit0
	DEC	W8
	BRA NZ	L_systemInit0
L_end_systemInit:
	POP	W12
	POP	W11
	POP	W10
	RETURN
; end of _systemInit

_applicationInit:

	PUSH	W10
	PUSH	W11
	MOV	#lo_addr(__MIKROBUS1_SPI), W11
	MOV	#lo_addr(__MIKROBUS1_GPIO), W10
	CALL	_mp3_spiDriverInit
	CALL	_mp3_init
	CALL	_mp3_reset
	MOV	#2048, W11
	MOV.B	#__MP3_MODE_ADDR, W10
	CALL	_mp3_cmdWrite
	MOV	#31232, W11
	MOV.B	#__MP3_BASS_ADDR, W10
	CALL	_mp3_cmdWrite
	MOV	#8192, W11
	MOV.B	#__MP3_CLOCKF_ADDR, W10
	CALL	_mp3_cmdWrite
	MOV.B	#47, W11
	MOV.B	#47, W10
	CALL	_mp3_setVolume
	MOV.B	#2, W11
	MOV	#lo_addr(?lstr1_Click_MP3_DSPIC), W10
	CALL	_mikrobus_logWrite
L_applicationInit2:
	CALL	_Mmc_Fat_Init
	CP0.B	W0
	BRA NZ	L__applicationInit29
	GOTO	L_applicationInit3
L__applicationInit29:
	GOTO	L_applicationInit2
L_applicationInit3:
L_applicationInit4:
	CLR	W11
	MOV	#lo_addr(_mp3_filename), W10
	CALL	_Mmc_Fat_Assign
	CP0.B	W0
	BRA Z	L__applicationInit30
	GOTO	L_applicationInit5
L__applicationInit30:
	GOTO	L_applicationInit4
L_applicationInit5:
L_end_applicationInit:
	POP	W11
	POP	W10
	RETURN
; end of _applicationInit

_applicationTask:

	PUSH	W10
	PUSH	W11
	MOV	#lo_addr(_file_size), W10
	CALL	_Mmc_Fat_Reset
	MOV.B	#2, W11
	MOV	#lo_addr(?lstr2_Click_MP3_DSPIC), W10
	CALL	_mikrobus_logWrite
L_applicationTask6:
	MOV	#512, W1
	MOV	#0, W2
	MOV	#lo_addr(_file_size), W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA LTU	L__applicationTask32
	GOTO	L_applicationTask7
L__applicationTask32:
	CLR	W0
	MOV	W0, _cnt
L_applicationTask8:
	MOV	_cnt, W1
	MOV	#512, W0
	CP	W1, W0
	BRA LTU	L__applicationTask33
	GOTO	L_applicationTask9
L__applicationTask33:
	MOV	#lo_addr(_mp3_buffer), W1
	MOV	#lo_addr(_cnt), W0
	ADD	W1, [W0], W0
	MOV	W0, W10
	CALL	_Mmc_Fat_Read
	MOV	#1, W1
	MOV	#lo_addr(_cnt), W0
	ADD	W1, [W0], [W0]
	GOTO	L_applicationTask8
L_applicationTask9:
	CLR	W0
	MOV	W0, _cnt
L_applicationTask11:
	MOV	_cnt, W0
	CP	W0, #16
	BRA LTU	L__applicationTask34
	GOTO	L_applicationTask12
L__applicationTask34:
L_applicationTask14:
	MOV	_cnt, W0
	SL	W0, #5, W1
	MOV	#lo_addr(_mp3_buffer), W0
	ADD	W0, W1, W0
	MOV	W0, W10
	CALL	_mp3_dataWrite32
	CP0.B	W0
	BRA NZ	L__applicationTask35
	GOTO	L_applicationTask15
L__applicationTask35:
	GOTO	L_applicationTask14
L_applicationTask15:
	MOV	#1, W1
	MOV	#lo_addr(_cnt), W0
	ADD	W1, [W0], [W0]
	GOTO	L_applicationTask11
L_applicationTask12:
	MOV	#512, W1
	MOV	#0, W2
	MOV	#lo_addr(_file_size), W0
	SUBR	W1, [W0], [W0++]
	SUBBR	W2, [W0], [W0--]
	GOTO	L_applicationTask6
L_applicationTask7:
	CLR	W0
	MOV	W0, _cnt
L_applicationTask16:
	MOV	_cnt, W1
	CLR	W2
	MOV	#lo_addr(_file_size), W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA LTU	L__applicationTask36
	GOTO	L_applicationTask17
L__applicationTask36:
	MOV	#lo_addr(_mp3_buffer), W1
	MOV	#lo_addr(_cnt), W0
	ADD	W1, [W0], W0
	MOV	W0, W10
	CALL	_Mmc_Fat_Read
	MOV	#1, W1
	MOV	#lo_addr(_cnt), W0
	ADD	W1, [W0], [W0]
	GOTO	L_applicationTask16
L_applicationTask17:
	CLR	W0
	MOV	W0, _cnt
L_applicationTask19:
	MOV	_cnt, W1
	CLR	W2
	MOV	#lo_addr(_file_size), W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA LTU	L__applicationTask37
	GOTO	L_applicationTask20
L__applicationTask37:
L_applicationTask22:
	MOV	#lo_addr(_mp3_buffer), W1
	MOV	#lo_addr(_cnt), W0
	ADD	W1, [W0], W0
	MOV.B	W0, W10
	CALL	_mp3_dataWrite
	CP0.B	W0
	BRA NZ	L__applicationTask38
	GOTO	L_applicationTask23
L__applicationTask38:
	GOTO	L_applicationTask22
L_applicationTask23:
	MOV	#1, W1
	MOV	#lo_addr(_cnt), W0
	ADD	W1, [W0], [W0]
	GOTO	L_applicationTask19
L_applicationTask20:
	MOV.B	#2, W11
	MOV	#lo_addr(?lstr3_Click_MP3_DSPIC), W10
	CALL	_mikrobus_logWrite
	CALL	_Delay_100ms
L_end_applicationTask:
	POP	W11
	POP	W10
	RETURN
; end of _applicationTask

_main:
	MOV	#2048, W15
	MOV	#6142, W0
	MOV	WREG, 32
	MOV	#1, W0
	MOV	WREG, 52
	MOV	#4, W0
	IOR	68

	CALL	_systemInit
	CALL	_applicationInit
L_main24:
	CALL	_applicationTask
	GOTO	L_main24
L_end_main:
L__main_end_loop:
	BRA	L__main_end_loop
; end of _main

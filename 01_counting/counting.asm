#include "p16F18855.inc" ; This contains all the definitions for our PIC

;PIC Config - We'll talk about this later
; __config 0x37EC
 __CONFIG _CONFIG1, _FEXTOSC_OFF & _RSTOSC_HFINT1 & _CLKOUTEN_OFF & _CSWEN_OFF & _FCMEN_ON
; CONFIG2
; __config 0x3FFF
 __CONFIG _CONFIG2, _MCLRE_ON & _PWRTE_OFF & _LPBOREN_OFF & _BOREN_ON & _BORV_LO & _ZCD_OFF & _PPS1WAY_ON & _STVREN_ON
; CONFIG3
; __config 0x3FFF
 __CONFIG _CONFIG3, _WDTCPS_WDTCPS_31 & _WDTE_OFF & _WDTCWS_WDTCWS_7 & _WDTCCS_SC
; CONFIG4
; __config 0x3FFF
 __CONFIG _CONFIG4, _WRT_OFF & _SCANE_available & _LVP_ON
; CONFIG5
; __config 0x3FFF
 __CONFIG _CONFIG5, _CP_OFF & _CPD_OFF

RES_VECT  CODE    0x0000            ; processor reset vector
    GOTO    START                   ; go to beginning of program

MAIN_PROG CODE                      ; let linker place main program

START

; use equ to assign friendly names to RAM addresses

COUNT1 equ 0x70			    ; Define a counter variable
COUNT2 equ 0x71			    ; and another so we can count > 256
LEDCOUNT equ 0x72		    ; how high we can count on our LEDS
CURRCOUNT equ 0x73		    ; the actual 'counter' for our leds
 
    MOVLW b'0000'   ; Set up PORTA 0-3 for output, 1s would set to input
    MOVWF TRISA	    ; We must explicitly set them to 0 to enable the output
    MOVLW 0x0f	    ; move 0x0f (decimal 15 b'1111') into accumulator
    MOVWF LEDCOUNT  ; write to LEDCOUNT
    MOVWF CURRCOUNT ; also write 15 to CURRCOUNT
    
LOOP ;label the start of our main loop
; write current count to the LEDS
    COMF CURRCOUNT,0	 ; take the complement (bitwise not) of the countdown
    MOVWF LATA		 ; write to the output latch
    
; delay loop
SL1	
    DECFSZ COUNT1,1  ; subtract one from counter2 and check for zero
    GOTO SL1	 ; go round again unless the counter reached zero
    DECFSZ COUNT2,1  ; subtract one from counter2 and check for zero
    GOTO SL1	 ; go round again unless the counter reached zero
	
    DECFSZ CURRCOUNT	 ; subtract one from our counter, check for zero
    GOTO LOOP		 ; loop round unless we reached zero
    
    MOVLW LEDCOUNT       
    MOVWF CURRCOUNT	; reset CURRCOUNT to 0x0f so we can start again
    GOTO LOOP           ;start again
    
    END	    ; assembler always needs an end statement
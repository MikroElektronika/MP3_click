#line 1 "C:/Users/katarina.perendic/Desktop/MP3_Click/example/c/PIC32/Click_MP3_PIC32.c"
#line 1 "c:/users/katarina.perendic/desktop/mp3_click/example/c/pic32/click_mp3_types.h"
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for pic32/include/stdint.h"




typedef signed char int8_t;
typedef signed int int16_t;
typedef signed long int int32_t;
typedef signed long long int64_t;


typedef unsigned char uint8_t;
typedef unsigned int uint16_t;
typedef unsigned long int uint32_t;
typedef unsigned long long uint64_t;


typedef signed char int_least8_t;
typedef signed int int_least16_t;
typedef signed long int int_least32_t;
typedef signed long long int_least64_t;


typedef unsigned char uint_least8_t;
typedef unsigned int uint_least16_t;
typedef unsigned long int uint_least32_t;
typedef unsigned long long uint_least64_t;



typedef signed long int int_fast8_t;
typedef signed long int int_fast16_t;
typedef signed long int int_fast32_t;
typedef signed long long int_fast64_t;


typedef unsigned long int uint_fast8_t;
typedef unsigned long int uint_fast16_t;
typedef unsigned long int uint_fast32_t;
typedef unsigned long long uint_fast64_t;


typedef signed long int intptr_t;
typedef unsigned long int uintptr_t;


typedef signed long long intmax_t;
typedef unsigned long long uintmax_t;
#line 1 "c:/users/katarina.perendic/desktop/mp3_click/example/c/pic32/click_mp3_config.h"
#line 1 "c:/users/katarina.perendic/desktop/mp3_click/example/c/pic32/click_mp3_types.h"
#line 3 "c:/users/katarina.perendic/desktop/mp3_click/example/c/pic32/click_mp3_config.h"
const uint32_t _MP3_SPI_CFG[ 7 ] =
{
 _SPI_MASTER,
 _SPI_8_BIT,
 80,
 _SPI_SS_DISABLE,
 _SPI_DATA_SAMPLE_MIDDLE,
 _SPI_CLK_IDLE_HIGH,
 _SPI_ACTIVE_2_IDLE
};
#line 1 "c:/users/katarina.perendic/desktop/mp3_click/library/__mp3_driver.h"
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for pic32/include/stdint.h"
#line 57 "c:/users/katarina.perendic/desktop/mp3_click/library/__mp3_driver.h"
extern const uint8_t _MP3_WRITE_CMD;
extern const uint8_t _MP3_READ_CMD;

extern const uint8_t _MP3_BASE_ADDR;
extern const uint8_t _MP3_MODE_ADDR;
extern const uint8_t _MP3_STATUS_ADDR;
extern const uint8_t _MP3_BASS_ADDR;
extern const uint8_t _MP3_CLOCKF_ADDR;
extern const uint8_t _MP3_DECODE_TIME_ADDR ;
extern const uint8_t _MP3_AUDATA_ADDR;
extern const uint8_t _MP3_WRAM_ADDR;
extern const uint8_t _MP3_WRAMADDR_ADDR;
extern const uint8_t _MP3_HDAT0_ADDR;
extern const uint8_t _MP3_HDAT1_ADDR;
extern const uint8_t _MP3_AIADDR_ADDR;
extern const uint8_t _MP3_VOL_ADDR;
extern const uint8_t _MP3_AICTRL0_ADDR;
extern const uint8_t _MP3_AICTRL1_ADDR;
extern const uint8_t _MP3_AICTRL2_ADDR;
extern const uint8_t _MP3_AICTRL3_ADDR;
#line 86 "c:/users/katarina.perendic/desktop/mp3_click/library/__mp3_driver.h"
void mp3_spiDriverInit( const uint8_t*  gpioObj,  const uint8_t*  spiObj);
#line 96 "c:/users/katarina.perendic/desktop/mp3_click/library/__mp3_driver.h"
void mp3_gpioDriverInit( const uint8_t*  gpioObj);
#line 103 "c:/users/katarina.perendic/desktop/mp3_click/library/__mp3_driver.h"
void mp3_init();
#line 108 "c:/users/katarina.perendic/desktop/mp3_click/library/__mp3_driver.h"
void mp3_reset();
#line 115 "c:/users/katarina.perendic/desktop/mp3_click/library/__mp3_driver.h"
uint8_t mp3_isBusy();
#line 123 "c:/users/katarina.perendic/desktop/mp3_click/library/__mp3_driver.h"
void mp3_cmdWrite( uint8_t address, uint16_t input );
#line 130 "c:/users/katarina.perendic/desktop/mp3_click/library/__mp3_driver.h"
uint16_t mp3_cmdRead( uint8_t address );
#line 137 "c:/users/katarina.perendic/desktop/mp3_click/library/__mp3_driver.h"
uint8_t mp3_dataWrite( uint8_t input );
#line 144 "c:/users/katarina.perendic/desktop/mp3_click/library/__mp3_driver.h"
uint8_t mp3_dataWrite32( uint8_t *input32 );
#line 37 "C:/Users/katarina.perendic/Desktop/MP3_Click/example/c/PIC32/Click_MP3_PIC32.c"
sbit Mmc_Chip_Select at LATD12_bit;
sbit Mmc_Chip_Select_Direction at TRISD12_bit;

const uint8_t BYTES_2_WRITE = 32;
const uint16_t BUFFER_SIZE = 512;

char mp3_filename[512] = "sound.mp3";
char mp3_buffer[BUFFER_SIZE];

uint32_t file_size;
uint16_t cnt = 0;

void mp3_setVolume(uint8_t volumeLeft, uint8_t volumeRight)
{
 uint16_t volume;
 volume = ( volumeLeft << 8 ) + volumeRight;
 mp3_cmdWrite(_MP3_VOL_ADDR, volume);
}

void systemInit()
{
 mikrobus_gpioInit( _MIKROBUS1, _MIKROBUS_AN_PIN, _GPIO_INPUT );
 mikrobus_gpioInit( _MIKROBUS1, _MIKROBUS_RST_PIN, _GPIO_OUTPUT );
 mikrobus_gpioInit( _MIKROBUS1, _MIKROBUS_CS_PIN, _GPIO_OUTPUT );
 mikrobus_gpioInit( _MIKROBUS1, _MIKROBUS_INT_PIN, _GPIO_OUTPUT );
 AD1PCFG = 0xFFFF;
 mikrobus_spiInit( _MIKROBUS1, &_MP3_SPI_CFG[0] );
 mikrobus_logInit( _LOG_USBUART_A, 9600 );
 Delay_ms( 100 );
}

void applicationInit()
{
 mp3_spiDriverInit( ( const uint8_t* )&_MIKROBUS1_GPIO, ( const uint8_t* )&_MIKROBUS1_SPI );
 mp3_init();
 mp3_reset();


 mp3_cmdWrite(_MP3_MODE_ADDR, 0x0800);
 mp3_cmdWrite(_MP3_BASS_ADDR, 0x7A00);
 mp3_cmdWrite(_MP3_CLOCKF_ADDR, 0x2000);


 mp3_setVolume( 0x2F, 0x2F );

 mikrobus_logWrite(" --- MMC FAT initialized",_LOG_LINE);
 while ( Mmc_Fat_Init());
 while ( !Mmc_Fat_Assign(&mp3_filename[0], 0));
}

void applicationTask()
{
 Mmc_Fat_Reset(&file_size);
 mikrobus_logWrite(" --- Play audio.",_LOG_LINE);
 while (file_size > BUFFER_SIZE)
 {
 for (cnt = 0; cnt < BUFFER_SIZE; cnt++)
 {
 Mmc_Fat_Read(mp3_buffer + cnt);
 }
 for (cnt = 0; cnt < BUFFER_SIZE / BYTES_2_WRITE; cnt++)
 {
 while( mp3_dataWrite32( mp3_buffer + cnt * BYTES_2_WRITE ));
 }
 file_size -= BUFFER_SIZE;
 }
 for (cnt = 0; cnt < file_size; cnt++)
 {
 Mmc_Fat_Read(mp3_buffer + cnt);
 }
 for (cnt = 0; cnt < file_size; cnt++)
 {
 while( mp3_dataWrite(mp3_buffer + cnt));
 }
 mikrobus_logWrite(" --- Finish! ",_LOG_LINE);
 Delay_100ms();
}

void main()
{
 systemInit();
 applicationInit();

 while (1)
 {
 applicationTask();
 }
}

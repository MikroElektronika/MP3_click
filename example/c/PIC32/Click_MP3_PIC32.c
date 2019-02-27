/*
Example for MP3 Click

    Date          : apr 2018.
    Author        : MikroE Team

Test configuration PIC32 :
    
    MCU                : P32MX795F512L
    Dev. Board         : EasyPIC Fusion v7
    PIC32 Compiler ver : v4.0.0.0

---

Description :

The application is composed of three sections :

- System Initialization - Initializes SPI module and sets INT, RST and CS pin as OUTPUT and AN pin as INPUT
- Application Initialization - Initializes driver init, MP3 init and reset procedure.
                               Standard configuration chip and set volume on the left and right channel.
                               Then initializes SD card and searching for songs on the SD card.
- Application Task - (code snippet) - Play audio, every 100 ms.

- note - In case the song crackles, increase the speed of the SPI
         Make sure that MMC card is properly formatted (to FAT16 or just FAT) before testing it on this example.
         Make sure that MMC card contains appropriate mp3 file ( sound.mp3 ).

*/

#include "Click_MP3_types.h"
#include "Click_MP3_config.h"

// microSD click module connections
sbit Mmc_Chip_Select           at LATD12_bit;
sbit Mmc_Chip_Select_Direction at TRISD12_bit;

const uint8_t BYTES_2_WRITE = 32;
const uint16_t BUFFER_SIZE = 512;

uint8_t mp3_filename[512] = {'s','o','u','n','d','.','m','p','3',0};
uint8_t mp3_buffer[BUFFER_SIZE];

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
    
    AD1PCFG = 0xFFFF; // Configure AN pins as digital I/O
    
    mikrobus_spiInit( _MIKROBUS1, &_MP3_SPI_CFG[0] );
    mikrobus_logInit( _LOG_USBUART_A, 9600 );
    Delay_ms( 100 );
}

void applicationInit()
{
    mp3_spiDriverInit( (T_MP3_P)&_MIKROBUS1_GPIO, (T_MP3_P)&_MIKROBUS1_SPI );
    mp3_init();
    mp3_reset();

    // MP3 configuration
    mp3_cmdWrite(_MP3_MODE_ADDR, 0x0800);
    mp3_cmdWrite(_MP3_BASS_ADDR, 0x7A00);
    mp3_cmdWrite(_MP3_CLOCKF_ADDR, 0x2000);

    // MP3 set volume, maximum volume is 0x00 and total silence is 0xFE.
    mp3_setVolume( 0x2F, 0x2F );

    mikrobus_logWrite(" --- Mmc (FAT) init start",_LOG_LINE);
    while ( 0 != Mmc_Fat_Init());
    while ( 1 != Mmc_Fat_Assign(&mp3_filename[0], 0));
    mikrobus_logWrite(" --- Mmc (FAT) init done",_LOG_LINE);
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
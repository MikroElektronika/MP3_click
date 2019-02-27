![MikroE](http://www.mikroe.com/img/designs/beta/logo_small.png)

---

# MP3 Click

---

- **CIC Prefix**  : MP3
- **Author**      : MikroE Team
- **Verison**     : 1.0.1
- **Date**        : apr 2018.

---

- **Libstock** : https://libstock.mikroe.com/projects/view/207/mp3-click
- **HEXIWEAR** : ${HEXI_LINK}
- **GitHub**   : ${GITHUB_LINK}

---

### Software Support

We provide a library for the MP3 Click on our [LibStock](https://libstock.mikroe.com/projects/view/207/mp3-click) 
page, as well as a demo application (example), developed using MikroElektronika 
[compilers](http://shop.mikroe.com/compilers). The demo can run on all the main 
MikroElektronika [development boards](http://shop.mikroe.com/development-boards).

**Library Description**

Initializes and defines SPI bus driver and driver functions witch offers a choice to write and read data/command. 

Key functions :

- ``` void mp3_init() ``` - Functions for initialize MP3 module
- ``` void mp3_cmdWrite( uint8_t address, uint16_t input ) ``` - Function writes one byte (command) to MP3
- ``` uint8_t mp3_dataWrite( uint8_t input ) ``` - Function writes one byte ( data ) to MP3
- ``` uint8_t mp3_dataWrite32( uint8_t *input32 ) ``` - Function Write 32 bytes ( data ) to MP3

**Examples Description**

The application is composed of three sections :

- System Initialization - Initializes SPI module and sets INT, RST and CS pin as OUTPUT and AN pin as INPUT
- Application Initialization - Initializes driver init, MP3 init and reset procedure. 
                               Standard configuration chip and set volume on the left and right channel.
                               Then initializes SD card and searching for songs on the SD card.
- Application Task - (code snippet) - Play audio, every 100 ms.

- note - In case the song crackles, increase the speed of the SPI
         Make sure that MMC card is properly formatted (to FAT16 or just FAT) before testing it on this example.
         Make sure that MMC card contains appropriate mp3 file ( sound.mp3 ).


```.c
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
```

Additional Functions :

- void mp3_setVolume(uint8_t volumeLeft, uint8_t volumeRight) - Functions for settings volume on the left and right channel.

The full application code, and ready to use projects can be found on our 
[LibStock](https://libstock.mikroe.com/projects/view/207/mp3-click) page.

Other mikroE Libraries used in the example:

- SPI
- UART
- Mmc
- Mmc_FAT16
- C_type

**Additional notes and informations**

Depending on the development board you are using, you may need 
[USB UART click](http://shop.mikroe.com/usb-uart-click), 
[USB UART 2 Click](http://shop.mikroe.com/usb-uart-2-click) or 
[RS232 Click](http://shop.mikroe.com/rs232-click) to connect to your PC, for 
development systems with no UART to USB interface available on the board. The 
terminal available in all Mikroelektronika 
[compilers](http://shop.mikroe.com/compilers), or any other terminal application 
of your choice, can be used to read the message.

---
---

# Chit Project - Optimizing Poultry House Climate for Enhanced Performance

* [Introduction](#Introduction)
* [Background](#Background)
* [Objective](#Objective)
* [Conclusion](#Conclusion)
* [Reference](#Reference)

## Introduction

Poultry farming is a delicate process that requires careful monitoring and control of various environmental factors to ensure the health and productivity of the birds. One of the key factors that influence the well-being and productivity of poultry is the climate within the poultry houses. This project aims to optimize the conditions within poultry farms, with a particular focus on temperature regulation, using Internet of Things (IoT) technology. [1]

## Background 

The optimal temperature inside the poultry house is a crucial factor for the well-being and productivity of the birds. An ambient temperature of 30 degrees Celsius is often considered comfortable for the birds. However, this temperature may feel pleasant or oppressive to the birds depending on the relative humidity inside the poultry house.

For instance, with high relative humidity, the birds may perceive the temperature to be higher than the actual ambient temperature. In such cases, the temperature setpoint can be adjusted slightly lower to ensure the birds remain in their thermal comfort zone. Conversely, with lower levels of humidity, the birds may perceive the temperature to be lower than the actual ambient temperature. Therefore, the temperature setpoint can be maintained slightly higher to ensure the birds’ comfort.

In more advanced systems, the temperature and humidity are not controlled separately. Instead, the climate controller determines the temperature setpoint by factoring in the effect of humidity. This approach ensures that the birds always remain in their thermal comfort zone, thereby optimizing their health, welfare, and productivity.

It’s important to note that while an ambient temperature of 30 degrees Celsius is often considered optimal, the actual optimal temperature may vary depending on various factors such as the type of birds, their age, and their health status. Therefore, continuous monitoring and adjustment of the temperature and other environmental conditions are essential for successful poultry farming.


## Objective

The objective of this project is to develop and implement an IoT-based system to monitor and control the temperature within poultry houses accurately. The system will use the IoT-m3 board and the lps331ap sensor to measure not only the ambient temperature but also the relative humidity and wind speed. The data collected will be processed using the RIOT language and the FIT IoT-LAB as the testbed. The ultimate goal is to maintain the birds in their thermal comfort zone, thereby optimizing their health, welfare, and productivity. This project aims to demonstrate the effectiveness of IoT technology in improving the conditions within poultry farms and, consequently, the results of poultry farming.



```c
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#include "thread.h"
#include "ztimer.h"
#include "shell.h"

#include "mutex.h"

#include "lpsxxx.h"
#include "lpsxxx_params.h"

static lpsxxx_t lpsxxx;

static void _lpsxxx_usage(char *cmd)
{
    printf("usage: %s <temperature|pressure>\n", cmd);
}

static int lpsxxx_handler(int argc, char *argv[])
{
    if (argc < 2) {
        _lpsxxx_usage(argv[0]);
        return -1;
    }

    /* Implement the lpsxxx temperature/pressure subcommands here */
     if (!strcmp(argv[1], "temperature")) {
        int16_t temp = 0;
        lpsxxx_read_temp(&lpsxxx, &temp);
        printf("Temperature: %i.%u°C\n", (temp / 100), (temp % 100));
    }
    else if (!strcmp(argv[1], "pressure")) {
        uint16_t pres = 0;
        lpsxxx_read_pres(&lpsxxx, &pres);
        printf("Pressure: %uhPa\n", pres);
    }
    else {
        _lpsxxx_usage(argv[0]);
        return -1;
    }

    return 0;
}

static const shell_command_t commands[] = {
    
    /* Add the lpsxxx command description here */
    { "lps", "read the lpsxxx values", lpsxxx_handler },


    { NULL, NULL, NULL}
};

int main(void)
{
    /* Initialize the lpsxxx sensor here */
    
    lpsxxx_init(&lpsxxx, &lpsxxx_params[0]);

    /* Everything is ready, let's start the shell now */
    char line_buf[SHELL_DEFAULT_BUFSIZE];
    shell_run(commands, line_buf, SHELL_DEFAULT_BUFSIZE);

    return 0;
}
```

## Conclusion
In conclusion, the project emphasizes the critical role of environmental conditions, particularly temperature, in poultry farming and proposes a sophisticated solution through the integration of Internet of Things (IoT) technology. Poultry farming is a complex endeavor where the well-being and productivity of birds are intricately tied to the climate within their houses. Maintaining an optimal ambient temperature is of paramount importance, and this project seeks to address this challenge with a focus on precise temperature regulation using IoT devices.
The background analysis underscores the nuances of temperature perception by poultry, influenced significantly by relative humidity levels. Recognizing that a standard ambient temperature may not universally apply due to variations in factors such as bird type, age, and health status, the project introduces a dynamic approach. This involves adjusting the temperature setpoint based on humidity levels, ensuring the birds consistently experience thermal comfort.
Moreover, the project outlines an objective to develop and implement an IoT-based system for accurate temperature monitoring and control within poultry houses. It introduces specific components, such as the IoT-m3 board and the lps331ap sensor, to measure ambient temperature, relative humidity, and wind speed. Leveraging the RIOT language and the FIT IoT-LAB as a testbed, the system aims to collect and process data effectively to optimize the birds' health, welfare, and productivity.
The provided code snippet demonstrates the practical implementation of the project, showcasing the use of the lpsxxx sensor to read temperature and pressure values. By incorporating commands for temperature and pressure handling, the system enables real-time monitoring and adjustment, aligning with the project's overarching goal of precise environmental control.
This project stands as a testament to the potential of IoT technology in agriculture, specifically poultry farming. By seamlessly integrating sensors, data processing, and control mechanisms, it not only enhances the efficiency of farming operations but also contributes to the well-being of the birds. The significance of continuous monitoring and adjustment in response to dynamic conditions is highlighted, emphasizing a proactive and adaptive approach to poultry farming.
As the agricultural sector continues to embrace technological advancements, projects like these pave the way for sustainable and optimized practices. The convergence of IoT and agriculture holds promise for increased efficiency, reduced resource wastage, and improved animal welfare, aligning with broader goals of promoting responsible and intelligent farming practices.

## Reference 

1. https://www.fancom.com/blog/what-is-the-optimal-temperature-for-poultry#:~:text=The%20birds%20will%20eat%20less,extreme%20temperatures%20can%20cause%20illness.
2. RIOT OS Documentation: https://riot-os.org/
3. FIT IoT-LAB Documentation: https://www.iot-lab.info/
4. [LPS331AP Sensor Datasheet](https://www.alldatasheet.com/datasheet-pdf/pdf/473924/STMICROELECTRONICS/LPS331AP.html)

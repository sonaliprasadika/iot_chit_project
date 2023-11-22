# Chit Project

* [Introduction](##Introduction)
* [Objective](###Objective)
* [Conclusion](##Conclusion)
* [Reference](##Reference)

## Introduction

This project aims to optimize bird farm harvest by implementing an IoT-based temperature monitoring system. The system utilizes RIOT OS as the firmware, FIT IOT-LAB as the testbed, IOT-m3 boards, and LPS331AP sensors for temperature measurement. The project's objective is to maintain the temperature inside the bird farms at the optimum level of 30 degrees Celsius, ensuring optimal conditions for bird growth and harvest. [1]



Among the sensors provided in the FIT IoT-LAB, we used lps331ap as the temperature and atmospheric pressure sensor. Only the temperature is measured here. The `main.c` file is as below. 

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

## Reference 

[1] https://www.fancom.com/blog/what-is-the-optimal-temperature-for-poultry#:~:text=The%20birds%20will%20eat%20less,extreme%20temperatures%20can%20cause%20illness.

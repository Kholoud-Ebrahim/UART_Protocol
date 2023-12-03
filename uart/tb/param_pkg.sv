/*###################################################################*\
##              Package Name:  param_pkg                             ##
##              Project Name: uart_protocl                           ##
##              Date:   3/12/2023                                    ##
##              Author: Kholoud Ebrahim Darwseh                      ##
\*###################################################################*/

package param_pkg;
    parameter DWIDTH   = 8;
    parameter PWIDTH   = 6; 
    parameter PRESCALE = 8;

    parameter TXPERIOD = 80; // RXPERIOD*PRESCALE
    parameter RXPERIOD = 10; 
endpackage :param_pkg
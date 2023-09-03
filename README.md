## UART implementation using system verilog

**UART** stands for universal asynchronous receiver / transmitter and defines a protocol, or set of rules, for exchanging serial data between two devices. UART is very simple and only uses two wires between transmitter and receiver to transmit and receive in both directions. Both ends also have a ground connection. Communication in UART can be **simplex** (data is sent in one direction only), **half-duplex** (each side speaks but only one at a time), or **full-duplex** (both sides can transmit simultaneously). Data in UART is transmitted in the form of **frames**.

![UART-BUS-between-two-devices](https://user-images.githubusercontent.com/110913003/228015604-ed3caf31-eb26-4deb-af11-e65b192e56c2.jpg)


One of the big advantages of UART is that it is **asynchronous** – the transmitter and receiver do not share a common clock signal. Although this greatly simplifies the protocol, it does place certain requirements on the transmitter and receiver.

Because UART is asynchronous, the transmitter needs to signal that data bits are coming. This is accomplished by using the start bit. The start bit is a transition from the idle high state to a low state, and immediately followed by user data bits.

The data frame contains the actual data being transferred. It can be five (5) bits up to eight (8) bits long if a parity bit is used. If no parity bit is used, the data frame can be nine (9) bits long. In most cases, the data is sent with the least significant bit first.

Parity describes the **evenness** or **oddness** of a number. The parity bit is a way for the receiving UART to tell if any data has changed during transmission. Bits can be changed by electromagnetic radiation, mismatched baud rates, or long-distance data transfers.

After the data bits are finished, the stop bit indicates the end of user data. The stop bit is either a transition back to the high or idle state or remaining at the high state for an additional bit time.

![UART-Packet](https://user-images.githubusercontent.com/110913003/228015690-086d9928-ff8d-4e99-b1ed-a75dba1f6291.png)



### In this repo i implemented the UART using **system verilog**


![2023-03-26_222119](https://user-images.githubusercontent.com/110913003/228015964-124af970-1049-4838-beea-bcf35cd02f59.png)


### The design consists of 4 main blocks:

1. Transmitter
2. Receiver
3. Buad rate generator
4. FIFO memory 

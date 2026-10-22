# SoundSense: IoT Interaction System for the Deaf

## Introduction
SoundSense is an innovative IoT solution designed to enable people with hearing impairments to interact with sound-emitting objects in their homes, such as doorbells, alarms, and other essential devices. This system uses a combination of smart technology and user-friendly interfaces to ensure seamless integration into daily life.
 

## How it works

```mermaid
flowchart LR
    bell["Doorbell ESP32<br/>(Esp 1.cpp)"] -- "WebSocket /ws<br/>heartbeat every 1 s, campainha" --> app["SoundSense app<br/>(Flutter)"]
    app -- "HTTP GET /led" --> led["Alert ESP32<br/>(Esp2.cpp)"]
    app -- "dialog: Campainha tocada" --> user(("User"))
    led -- "LED on GPIO 2" --> user
```

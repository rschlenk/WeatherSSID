# WeatherSSID
Broadcast weather forecast in SSID

***

## Contents
 1. [About](#1-about)
 2. [License](#2-license)
 3. [Prerequisites](#3-prerequisites)
 4. [Usage](#4-usage)
 5. [Exit status](#5-exit-status)

***

## 1. About

WeatherSSID broadcasts an additional SSID on Freifunk/OpenWRT routers.
This SSID shows the predicted max temperature for the respective day. Weather forecast is obtained from [OpenWeatherMap](http://openweathermap.org/).
_In this version, only a default SSID is sent out._

## 2. License

This project is licensed under GNU General Public License v3.0. For the full license, see `LICENSE`.

## 3. Prerequisites

 * Freifunk/OpenWRT router with hostapd up and running.
 * OpenWeatherMap API key ([http://openweathermap.org/appid](http://openweathermap.org/appid)).
 * _tbd_

## 4. Usage

WeatherSSID [start|stop]
_tbd_

## 5. Exit status

 * `0`: WeatherSSID exited successfully.
 * `1`: Missing command-line arguments.



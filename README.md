# hubot-uptime-robot

A hubot script that shows the status of all Uptime Robot Monitors.

See [`src/uptimerobot.coffee`](src/uptimerobot.coffee) for full documentation.

## Installation

In hubot project repo, run:

`npm install hubot-uptime-robot --save`

Then add **hubot-uptime-robot** to your `external-scripts.json`:

```json
[
  "hubot-uptime-robot"
]
```

## Sample Interaction

```
user1>> hubot uptime
hubot>> 
Name      Status  Uptime
--------  ------  ------
Website   DOWN    99.95%
API       UP      100%
```

# Description:
#   Uptime Robot Status
#
#   Show the status of all Uptime Robot Monitors
#
# Dependencies:
#   "easy-table": "^1.0.0"
#
# Configuration:
#   HUBOT_UPTIMEROBOT_APIKEY
#
# Commands:
#   hubot uptime - Shows the current Uptime Robot monitor status
#
# Author:
#   mhemmings

Table = require 'easy-table'

apiKey = process.env.HUBOT_UPTIMEROBOT_APIKEY

module.exports = (robot) ->
  robot.respond /uptime/i, (res) ->
    robot.http('https://api.uptimerobot.com/getMonitors')
      .query({
        apiKey: apiKey
        format: "json"
        noJsonCallback: 1
      })
      .get() (err, resp, body) ->
        if err
          res.send "Encountered an error :( #{err}"
          return
        data = null
        try
          data = JSON.parse body
        catch error
          res.send 'Ran into an error parsing JSON :('
          return
        if data.monitors.monitor.length is 0
          res.send 'No monitors registered'
          return

        t = new Table

        data.monitors.monitor.forEach (monitor) ->
          status = switch monitor.status
            when '0' then 'Paused'
            when '1' then 'Not Checked Yet'
            when '2' then 'UP'
            when '8' then 'Seems Down'
            when '9' then 'DOWN'

          t.cell 'Name', monitor.friendlyname
          t.cell 'Status', status
          t.cell 'Uptime', monitor.alltimeuptimeratio + '%'
          t.newRow()


        res.send "\n```#{t.toString()}```"

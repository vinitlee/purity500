# App --------------

express = require 'express'
app = express()

# Imports ----------

path = require('path')
cookieParser = require('cookie-parser')
bodyParser = require('body-parser')

# Routing ----------

routes = require('./routes/index')
app.use('/',routes)

# Views ------------

app.set('views',path.join(__dirname,'views'))
app.set('view engine','jade')

# Middleware ------

app.use(cookieParser())
app.use(bodyParser.json())
app.use(bodyParser.urlencoded({extended: false}))

app.use(express.static(path.join(__dirname, 'public')))

# Serving ----------

app.set('port',process.env.PORT or 3000)

server = app.listen app.get('port'), () ->
  host = server.address().address
  port = server.address().port

  console.log 'App listening at http://%s:%s', host, port
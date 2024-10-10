pipeline {
agent { label 'mac-mini-slave' }
parameters {
  // the default choice for commit-triggered builds is the first item in the choices list
  choice(name: 'buildVariant', choices: ['Debug_Scan_Only', 'Debug_TestFlight', 'Release_AppStore_TestFlight'], description: 'The variants to build')
 }
environment {
LC_ALL = 'en_US.UTF-8'
APP_NAME = 'eCabsTask'
BUILD_NAME = 'eCabsTask'
APP_TARGET = 'eCabsTask'
APP_PROJECT = 'eCabsTask.xcodeproj'
APP_WORKSPACE = 'eCabsTask.xcworkspace'
APP_TEST_SCHEME = 'eCabsTask'
PUBLISH_TO_CHANNEL = 'teams'
}
stages {
...
}
}

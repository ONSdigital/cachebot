module github.com/ONSdigital/cachebot

go 1.19

// fix for CVE-2022-32149, CVE-2020-14040
replace golang.org/x/text => golang.org/x/text v0.5.0

require (
	github.com/ian-kent/gofigure v0.0.0-20170502192241-c9dc3a1359af
	github.com/slack-go/slack v0.12.1
)

require (
	github.com/gopherjs/gopherjs v1.17.2 // indirect
	github.com/gorilla/websocket v1.5.0 // indirect
	github.com/ian-kent/envconf v0.0.0-20141026121121-c19809918c02 // indirect
	github.com/smartystreets/assertions v1.13.0 // indirect
	github.com/smartystreets/goconvey v1.7.2 // indirect
)

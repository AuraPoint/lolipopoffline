// Core part of Lolipop: Offline
const RPC = require("discord-rpc");
require("./server");


// Loads env.json for Wrapper version and build number
const env = Object.assign(process.env,
	require('./env'));
// env.json variables
let version = env.WRAPPER_VER;
let build = env.WRAPPER_BLD;


// Discord rich presence
const rpc = new RPC.Client({
	transport: "ipc"
});
rpc.on("ready", () => {
	// Sets RPC activity
	rpc.setActivity({
		state: "Making a video/character",
		details: "Version 0.1.0 PRIVATE BETA"
		startTimestamp: new Date(),
		largeImageKey: "large",
		largeImageText: "Lolipop: Offline",
		smallImageKey: "small",
		smallImagetext: "Lolipop: Offline",
	});
	// Logs "Rich presence is on!" in the console
	console.log("Rich presence is on!")
});
// Connects RPC to app
rpc.login({
	clientId: "853604354019950593"
});

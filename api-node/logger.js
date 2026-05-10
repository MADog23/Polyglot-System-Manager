function logInfo(msg) {
    console.log(`[INFO] ${msg}`);
}

function logWarn(msg) {
    console.warn(`[WARN] ${msg}`);
}

function logError(msg) {
    console.error(`[ERROR] ${msg}`);
}

module.exports = { logInfo, logWarn, logError };

/*global JSLINT load readline print */

load('fulljslint.js');

var readSTDIN = function() {
    var line, 
        input = [], 
        emptyCount = 0,
        i;

    line = readline();
    while (emptyCount < 25) {
        input.push(line);
        if (line) {
            emptyCount = 0;
        } else {
            emptyCount += 1;
        }
        line = readline();
    }

    input.splice(-emptyCount);
    return input.join("\n");
};

var body = readSTDIN() || arguments[0],
    ok = JSLINT(body),
    i,
    error,
    errorCount;

if (!ok) {
    errorCount = JSLINT.errors.length;
    for (i = 0; i < errorCount; i += 1) {
        error = JSLINT.errors[i];
        if (error && error.reason && error.reason.match(/^Stopping/) === null) {
            print([error.line, error.character, error.reason].join(":"));
        }
    }
}


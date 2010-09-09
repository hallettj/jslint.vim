/*global JSLINT load readline print laxbreak:true */

load('fulljslint.js');

// Import extra libraries if running in Rhino.
if (typeof importPackage != 'undefined') {
    importPackage(java.io);
    importPackage(java.lang);
}

var readSTDIN = (function() {
    // readSTDIN() definition for Rhino
    if (typeof BufferedReader != 'undefined') {
        return function readSTDIN() {
            // setup the input buffer and output buffer
            var stdin = new BufferedReader(new InputStreamReader(System['in'])),
                lines = [];

            // read stdin buffer until EOF (or skip)
            while (stdin.ready()){
                lines.push(stdin.readLine());
            }

            return lines.join('\n');
        };

    // readSTDIN() definition for Spidermonkey
    } else if (typeof readline != 'undefined') {
        return function readSTDIN() {
            var line
              , input = []
              , emptyCount = 0
              , i;

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
    }
})();

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

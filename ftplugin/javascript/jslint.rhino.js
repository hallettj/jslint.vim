/*global JSLINT load readline print */

load('fulljslint.js');
importPackage(java.io);
importPackage(java.lang);

function readSTDIN() {
	// setup the input buffer and output buffer
	var stdin = new BufferedReader(new InputStreamReader(System['in'])),
	    lines = [];
 
	// read stdin buffer until EOF (or skip)
	while (stdin.ready()){
		lines.push(stdin.readLine());
	}
 
    return lines.join('\n');
}

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


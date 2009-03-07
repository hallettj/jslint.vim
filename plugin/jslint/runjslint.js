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
    result = JSLINT(body),
    i,
    error;

if (result) {
    print('All good.');
} else {
    print('Error:');
    for (i = 0; i < JSLINT.errors.length; i++) {
        error = JSLINT.errors[i];
        print('Problem at line ' + error.line + ' character ' + error.character + ': ' + error.reason);
        print(error.evidence);
    }
}

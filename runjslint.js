/*global JSLINT load print */

load('fulljslint.js');

    function to_array(o) {
        var a = [], k;
        for (k in o) {
            if (o.hasOwnProperty(k)) {
                a.push(k);
            }
        }
        return a;
    }

var body = arguments[0],
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

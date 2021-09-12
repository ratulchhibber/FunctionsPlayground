/**
 Pure and Total are orthogonal concepts- A function can be one, both or neither.
 
 **Functions-**
 If inputs are to the left, and outputs are to the right-
 1. Right unique - All outputs should be unique.
 2. Left total- Mappings to the right, are defined for all inputs.
 
 **Pure Functions-**
 1. Deterministic- All inputs produce a single output
 2. No side effects- Function does not do any mutation/ modification of outside data/ Does not throw exceptions for any cases -> In short, does not do anything except return its output.
 
 Pure functions have "Referential Transparency"- You can replace result of an invocation(function) with the invovation itself.
 
 Race conditions and other multithreading issues are only due to presence of side effects in a function, which are not present in Pure functions.
 
 **Total functions-**
 A function is called Total- If it is defined for all input values.
 
 **Non-Total functions/Partial functions-**
 A function which is not defined for some of the inputs is called a partial function.
 
 **A non-total function can be -**
 1. Impure - Function throws an exception(This is a side effect) and caller observes it via catch.
 2. Pure - If a non-total function does not throw an exception and thereby, consequently getting caught. But if it provides no facility to catch an expection(example- fatalError)- This becomes a pure function.
 */

//Examples-

//This function is Pure and Total
func toggle(value isOn: Bool) -> Bool {
    return !isOn
}

//This function is Not pure(since it has a side effect, but is Total)
var counter = 0
func flipMe(value isOn: Bool) -> Bool {
    counter += 1 // Side-effect
    return !isOn
}

//This function is neither pure, nor total
func divide(by number: Int) -> Int {
    counter += 1
    return 100/number
}

// This function is Partial(non-total) and impure
enum DivisionError: Error {
    case undefined
}
func division(by number: Int) throws -> Int {
    if number == 0 {
        throw DivisionError.undefined // Side effect
    }
    return 100/number
}

// This function is Partial(non-total)
// Pure and Impure is dependent here on the frame of reference
// Pure for the caller-> Only because there is no means to determine(observe) its deterministic behaviour and side effect for (zero input).
// Impure if reading from stack-trace-> Since, you may observe that it threw a fatalError for zero input.
func divideBy(number: Int) -> Int { // Note: This is not throwing
    if number == 0 {
        fatalError("This is not defined")//side effect but cannot be obsereved by caller
    }
    return 100/number
}


// This function is Partial(non-total)
// Pure and Impure is dependednt here on the frame of reference
// Pure for the caller-> Only because there is no means to determine(observe) its deterministic behaviour and side effect for (zero input - It is a fatalError).
// Impure if reading from stack-trace-> Since, you may observe the side effect.
func divideNow(number: Int) -> Int { // Note: This is not throwing
    counter += 1//Side effect
    if number == 0 {
        fatalError("This is not defined")//Side effect
    }
    return 100/number
}

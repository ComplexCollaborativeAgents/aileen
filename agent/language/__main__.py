from agent.language.Interpreter import Interpreter

if __name__ == "__main__":
    interpreter = Interpreter()
    test_nl = "can you please get me a glass of water?"

    isr = interpreter.interpret(test_nl)`
    print(isr)



import json
from langchain_openai import ChatOpenAI
from langchain.prompts.few_shot import FewShotPromptTemplate
from langchain.prompts.prompt import PromptTemplate
from langchain_core.output_parsers import StrOutputParser
import settings
import os


def to_json(generated_string):
    json_string = json.loads(generated_string.replace("[", "{").replace("]", "}"))
    return json_string


class Interpreter:
    def __init__(self):
        os.environ['OPENAI_API_KEY'] = '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'
        self._prompt = self.create_interpretation_few_shot_prompt()
        self._gpt_model = ChatOpenAI(model_name='gpt-3.5-turbo-0613')
        self._output_parser = StrOutputParser()
        self._chain = self._prompt | self._gpt_model | self._output_parser
        pass

    def read_few_shot_prompt_examples(self):
        json_examples = json.load(
            open(os.path.join(settings.ROOT_PATH, 'agent', 'language', 'data', 'nl-to-ISR-examples.json')))
        examples = []
        for jex in json_examples:
            language = jex['language']
            semantics = "{}".format(jex['semantics']).replace("{", "[").replace("}", "]").replace("'", "\"")
            pair = {"language": language, "semantics": semantics}
            examples.append(pair)
        return examples

    def create_interpretation_few_shot_prompt(self):
        example_prompt = PromptTemplate(input_variables=["language", "semantics"],
                                        template="language: {language}\n{semantics}")
        examples = self.read_few_shot_prompt_examples()
        prompt = FewShotPromptTemplate(
            examples=examples,
            example_prompt=example_prompt,
            suffix="language: {input}",
            input_variables=["input"],
        )
        return prompt

    def interpret(self, nl_string):
        generated_string = self._chain.invoke({"input": nl_string})
        json_string = to_json(generated_string)
        return json_string

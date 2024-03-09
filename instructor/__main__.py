import jsonrpclib.jsonrpc
import streamlit as st
import settings
import logging, coloredlogs
logger = logging.getLogger(__name__)
coloredlogs.install(level='DEBUG', logger=logger)

def create_connection_with_agent():
    url = 'http://{}:{}'.format(settings.AGENT_HOST, settings.AGENT_SERVER_PORT)
    logging.info("connecting to the agent server at host: {}, port: {}".format(settings.AGENT_HOST, settings.AGENT_SERVER_PORT))
    server = jsonrpclib.jsonrpc.ServerProxy(url)
    return server
def send_message_to_agent(server, message):
    agent_message = server.process_utterance(message)
    return agent_message


if __name__ == "__main__":
    agent_server = create_connection_with_agent()
    st.title("Talk to Aileen!")

    # Initialize chat history
    if "messages" not in st.session_state:
        st.session_state.messages = []

    # Display chat messages from history on app rerun
    for message in st.session_state.messages:
        with st.chat_message(message["role"]):
            st.markdown(message["content"])

    # React to user input
    if prompt := st.chat_input("Ask Aileen to do something"):
        # Display user message in chat message container
        st.chat_message("user").markdown(prompt)
        # Add user message to chat history
        st.session_state.messages.append({"role": "user", "content": prompt})

        response = send_message_to_agent(agent_server, prompt)
        # Display assistant response in chat message container
        with st.chat_message("assistant"):
            st.markdown(response)
        # Add assistant response to chat history
        st.session_state.messages.append({"role": "assistant", "content": response})



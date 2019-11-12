import React from "react";
import PropTypes from "prop-types";
import ActionCable from "actioncable";
import {
  ActionCableProvider,
  ActionCableConsumer
} from "react-actioncable-provider";

class TopShortUrls extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      currentShortUrls: props.short_urls
    };
  }

  handleReceived = updatedShortUrls => {
    this.setState({
      currentShortUrls: updatedShortUrls
    });
  };

  render() {
    const { currentShortUrls } = this.state;

    if (!currentShortUrls) return <p>empty</p>;

    const cable = ActionCable.createConsumer(
      `ws://${window.location.host}/cable`
    );

    const top_urls = currentShortUrls.map((short_url, index) => (
      <li key={index}>
        {short_url.title} - Visits: {short_url.visits_count}
      </li>
    ));

    return (
      <ActionCableProvider cable={cable}>
        <ActionCableConsumer
          channel="TopShortUrlsChannel"
          onReceived={this.handleReceived}
        >
          {top_urls}
        </ActionCableConsumer>
      </ActionCableProvider>
    );
  }
}

TopShortUrls.propTypes = {
  short_urls: PropTypes.array
};
export default TopShortUrls;

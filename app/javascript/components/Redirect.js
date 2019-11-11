import React from "react";
import PropTypes from "prop-types";

class Redirect extends React.Component {
  componentDidMount() {
    const { url } = this.props;

    setTimeout(function() {
      window.location.href = url;
    }, 5000);
  }

  render() {
    const { url } = this.props;

    return (
      <React.Fragment>
        You are being redirected to
        <b> {url} </b>
        in 5 seconds!
      </React.Fragment>
    );
  }
}

Redirect.propTypes = {
  url: PropTypes.string
};
export default Redirect;

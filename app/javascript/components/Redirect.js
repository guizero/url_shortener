import React from "react";
import PropTypes from "prop-types";
import LoadingScreen from "react-loading-screen";

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
      <LoadingScreen
        loading={true}
        bgColor="#f1f1f1"
        spinnerColor="#9ee5f8"
        textColor="#676767"
        text={`You are being redirected to ${url}`}
      />
    );
  }
}

Redirect.propTypes = {
  url: PropTypes.string
};
export default Redirect;

import React from "react";
import axios from "axios";

class Create extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      long_url: "http://",
      short_code: null
    };
  }

  handleChange = event => {
    this.setState({ long_url: event.target.value });
  };

  handleSubmit = event => {
    event.preventDefault();
    axios
      .post("/", {
        long_url: this.state.long_url
      })
      .then(response => {
        if (response.status === 200) {
          this.setState({
            short_code: response.data.short_code
          });
        }
      })
      .catch(error => {
        console.log(error);
      });
  };

  render() {
    const { long_url, short_code } = this.state;
    const short_url = `${window.location.origin}/${short_code}`;

    return (
      <React.Fragment>
        Create your shortened url!
        <br />
        <form onSubmit={this.handleSubmit}>
          <input type="text" value={long_url} onChange={this.handleChange} />
          <input type="submit" value="Submit" />
        </form>
        {short_code && (
          <span>
            The short url is <a href={short_url}>{short_url}</a>
          </span>
        )}
      </React.Fragment>
    );
  }
}

export default Create;

import React, { useState } from "react";
import PropTypes from "prop-types";
import ActionCable from "actioncable";
import {
  ActionCableProvider,
  ActionCableConsumer
} from "react-actioncable-provider";
import { makeStyles } from "@material-ui/core/styles";
import Table from "@material-ui/core/Table";
import TableBody from "@material-ui/core/TableBody";
import TableCell from "@material-ui/core/TableCell";
import TableHead from "@material-ui/core/TableHead";
import TableRow from "@material-ui/core/TableRow";
import Paper from "@material-ui/core/Paper";
import Container from "@material-ui/core/Container";
import Linkify from "react-linkify";
import Typography from "@material-ui/core/Typography";
import Button from "@material-ui/core/Button";
import CircularProgress from "@material-ui/core/CircularProgress";
import axios from "axios";

const useStyles = makeStyles({
  root: {
    width: "100%",
    overflowX: "auto"
  },
  table: {
    minWidth: 650
  }
});

function TopShortUrls(props) {
  const [shortUrls, setShortUrls] = useState(props.short_urls);
  const [loadingShortUrls, setLoadingShortUrls] = useState(false);

  const handleReceived = updatedShortUrls => {
    setShortUrls(updatedShortUrls);
  };

  const generateRandom = event => {
    setLoadingShortUrls(true);

    event.preventDefault();
    axios
      .post("/generate", {})
      .then(response => {
        setLoadingShortUrls(false);
      })
      .catch(error => {
        console.log(error);
      });
  };

  if (!shortUrls) return <p>No short links have yet been created.</p>;

  const classes = useStyles();

  const cable = ActionCable.createConsumer(
    `ws://${window.location.host}/cable`
  );

  return (
    <ActionCableProvider cable={cable}>
      <ActionCableConsumer
        channel="TopShortUrlsChannel"
        onReceived={handleReceived}
      >
        <Container component="main" maxWidth="lg">
          <Typography variant="h4" gutterBottom>
            Top 100 short urls ranked by visits!
          </Typography>
          <br />
          <br />
          <Paper className={classes.root}>
            <Table className={classes.table} aria-label="simple table">
              <TableHead>
                <TableRow>
                  <TableCell>
                    <b>Ranking</b>
                  </TableCell>
                  <TableCell align="right">
                    <b>Title</b>
                  </TableCell>
                  <TableCell align="right">Short Url</TableCell>
                  <TableCell align="right">Long Url</TableCell>
                  <TableCell align="right">Visits</TableCell>
                </TableRow>
              </TableHead>
              <TableBody>
                {shortUrls.map((shortUrl, index) => (
                  <TableRow key={index + 1}>
                    <TableCell component="th" scope="row">
                      {index + 1}
                    </TableCell>
                    <TableCell align="right">
                      {shortUrl.title || "Title has still not been fetched!"}
                    </TableCell>
                    <TableCell align="right">{`${window.location.origin}/${shortUrl.short_code}`}</TableCell>
                    <TableCell align="right">
                      <Linkify>{shortUrl.long_url}</Linkify>
                    </TableCell>
                    <TableCell align="right">
                      <Linkify>{shortUrl.visits_count}</Linkify>
                    </TableCell>
                  </TableRow>
                ))}
              </TableBody>
            </Table>
          </Paper>
          <Button
            type="submit"
            fullWidth
            variant="contained"
            color="primary"
            onClick={generateRandom}
            disabled={loadingShortUrls}
            endIcon={loadingShortUrls && <CircularProgress />}
          >
            Generate random short urls!
          </Button>
        </Container>
      </ActionCableConsumer>
    </ActionCableProvider>
  );
}

TopShortUrls.propTypes = {
  short_urls: PropTypes.array
};

export default TopShortUrls;

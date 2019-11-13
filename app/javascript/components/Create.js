import React, { useState } from "react";
import axios from "axios";
import Avatar from "@material-ui/core/Avatar";
import Button from "@material-ui/core/Button";
import CssBaseline from "@material-ui/core/CssBaseline";
import TextField from "@material-ui/core/TextField";
import Link from "@material-ui/icons/Link";
import Typography from "@material-ui/core/Typography";
import { makeStyles } from "@material-ui/core/styles";
import Container from "@material-ui/core/Container";
import Dialog from "@material-ui/core/Dialog";
import DialogActions from "@material-ui/core/DialogActions";
import DialogContent from "@material-ui/core/DialogContent";
import DialogContentText from "@material-ui/core/DialogContentText";
import DialogTitle from "@material-ui/core/DialogTitle";
import Confetti from "react-dom-confetti";

const useStyles = makeStyles(theme => ({
  "@global": {
    body: {
      backgroundColor: theme.palette.common.white
    }
  },
  paper: {
    marginTop: theme.spacing(8),
    display: "flex",
    flexDirection: "column",
    alignItems: "center"
  },
  avatar: {
    margin: theme.spacing(1),
    backgroundColor: theme.palette.primary.main
  },
  form: {
    width: "100%",
    marginTop: theme.spacing(1)
  },
  submit: {
    margin: theme.spacing(3, 0, 2)
  }
}));

const Create = () => {
  const [longUrl, setLongUrl] = useState("http://");
  const [shortCode, setShortCode] = useState(null);
  const [openDialog, setOpenDialog] = useState(false);

  const handleChange = event => {
    setLongUrl(event.target.value);
  };

  const handleSubmit = event => {
    event.preventDefault();
    axios
      .post("/", {
        long_url: longUrl
      })
      .then(response => {
        if (response.status === 200) {
          setShortCode(response.data.short_code);
          setOpenDialog(true);
        }
      })
      .catch(error => {
        console.log(error);
      });
  };

  const handleCloseDialog = () => {
    setOpenDialog(false);
  };

  const shortUrl = `${window.location.origin}/${shortCode}`;
  const classes = useStyles();

  return (
    <Container component="main" maxWidth="md">
      <CssBaseline />
      <div className={classes.paper}>
        <Avatar className={classes.avatar}>
          <Link />
        </Avatar>
        <Typography component="h1" variant="h5">
          Url Link Shortener
        </Typography>
        <form className={classes.form} onSubmit={handleSubmit} noValidate>
          <TextField
            variant="outlined"
            margin="normal"
            required
            fullWidth
            id="long_url"
            label="Shorten your link"
            name="long_url"
            autoFocus
            value={longUrl}
            onChange={handleChange}
          />
          <Button
            type="submit"
            fullWidth
            variant="contained"
            color="primary"
            className={classes.submit}
          >
            Shorten
          </Button>
        </form>
        <a href="/top-urls">Check the top 100 short urls!</a>
        <Confetti active={openDialog} />
      </div>
      <Dialog
        open={openDialog}
        onClose={handleCloseDialog}
        aria-labelledby="alert-dialog-title"
        aria-describedby="alert-dialog-description"
      >
        <DialogTitle id="alert-dialog-title">{"Yippee!"}</DialogTitle>
        <DialogContent>
          <DialogContentText id="alert-dialog-description">
            Your short link was created successfully:
            <br />
            <a href={shortUrl} target="_blank">
              {shortUrl}
            </a>
          </DialogContentText>
        </DialogContent>
        <DialogActions>
          <Button onClick={handleCloseDialog} color="primary">
            Close
          </Button>
        </DialogActions>
      </Dialog>
    </Container>
  );
};

export default Create;

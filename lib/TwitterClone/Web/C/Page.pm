package TwitterClone::Web::C::Page;
use strict;
use warnings;
use utf8;

use TwitterClone::Repository::Text;

sub get_root {
  my ($class, $c, $args) = @_;

  return $c->render('form.tx', {
      action => '/',
      button => 'create',
    });
}

sub get_id {
  my ($class, $c, $args) = @_;
  my $id = $args->{id};

  my $text = TwitterClone::Repository::Text->fetch_by_id($id)
    or return $c->res_404;

  $c->fillin_form({text => $text});
  return $c->render('form.tx', {
      action => "/$id",
      button => 'update',
    });
}

sub post_root {
  my ($class, $c, $args) = @_;

  my $text = $c->req->parameters->{text}
    or return $c->res_400;

  my $id = TwitterClone::Repository::Text->create($text);

  return $c->redirect("/$id");
}

sub post_id {
  my ($class, $c, $args) = @_;
  my $id = $args->{id};

  my $text = $c->req->parameters->{text} or return $c->res_400;
  my $old_text = TwitterClone::Repository::Text->fetch_by_id($id) or return $c->res_404;

  TwitterClone::Repository::Text->update($id, $text);

  return $c->redirect("/$id");
}

1;

package TwitterClone::Repository::Mention;
use strict;
use warnings;
use utf8;
use Data::Dumper;
use TwitterClone;

sub db { TwitterClone->context->db }

sub fetch_screen_name_posts {
  my ($class, $user_id) = @_;

  my $itr = $class->db->search_named(q{select message.id, message.user_id, message.text, message.image as message_image, message.mention, message.deleted, message.created_at, user.screen_name, user.name, user.image as user_image from message inner join user on message.user_id = user.id  where message.mention = :user_id and message.deleted = :num order by created_at desc}, {user_id => $user_id, num => 0});
  my @messages = $itr->all;
  $class->parse(@messages);
  return @messages;
}

sub fetch_user_profile {
  my ($class, $user_id) = @_;
  return $class->db->single(user => {id => $user_id});
}

sub parse {
  my ($class, @messages) = @_;

  for (my $i = 0; $i <= $#messages; $i++){
    my $date = $messages[$i]->{row_data}->{created_at};
    $date =~ s/-/年/;
    $date =~ s/-/月/;
    $date =~ s/ /日 /;
    my @list = split(/:/, $date);
    my $new_date = $list[0] . ":" .  $list[1] . "\n";
    $messages[$i]->{row_data}->{created_at} = $new_date;
  }
}

1;
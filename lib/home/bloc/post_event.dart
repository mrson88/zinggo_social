part of 'post_bloc.dart';

@immutable
abstract class PostEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadData extends PostEvent {
  final String userdata;

  LoadData(this.userdata);
}

import 'package:posts_repository/src/models/models.dart';
import 'package:posts_repository/src/posts_repository_abstract.dart';

final mockPosts = <Post>[
  Post(
    id: '1',
    title: 'Post 1',
    caption: 'Post 1 body',
    image: 'https://picsum.photos/200/300',
    createdAt: DateTime.now(),
    deletedAt: DateTime.now(),
    tags: const ['tag1', 'tag2', 'tag3'],
    updatedAt: DateTime.now(),
    user: PostUser(
      id: '1',
      username: 'User 1',
      avatar: 'https://picsum.photos/200/300',
    ),
    userId: '1',
  ),
  Post(
    id: '2',
    title: 'Post 2',
    caption: 'Post 2 body',
    image: 'https://picsum.photos/200/300',
    createdAt: DateTime.now(),
    deletedAt: DateTime.now(),
    tags: const ['tag1', 'tag2', 'tag3'],
    updatedAt: DateTime.now(),
    user: PostUser(
      id: '2',
      username: 'User 2',
      avatar: 'https://picsum.photos/200/300',
    ),
    userId: '2',
  ),
  Post(
    id: '3',
    title: 'Post 3',
    caption: 'Post 3 body',
    image: 'https://picsum.photos/200/300',
    createdAt: DateTime.now(),
    deletedAt: DateTime.now(),
    tags: const ['tag1', 'tag2', 'tag3'],
    updatedAt: DateTime.now(),
    user: PostUser(
      id: '3',
      username: 'User 3',
      avatar: 'https://picsum.photos/200/300',
    ),
    userId: '3',
  ),
  Post(
    id: '4',
    title: 'Post 4',
    caption: 'Post 4 body',
    image: 'https://picsum.photos/200/300',
    createdAt: DateTime.now(),
    deletedAt: DateTime.now(),
    tags: const ['tag1', 'tag2', 'tag3'],
    updatedAt: DateTime.now(),
    user: PostUser(
      id: '4',
      username: 'User 4',
      avatar: 'https://picsum.photos/200/300',
    ),
    userId: '4',
  ),
  Post(
    id: '5',
    title: 'Post 5',
    caption: 'Post 5 body',
    image: 'https://picsum.photos/200/300',
    createdAt: DateTime.now(),
    deletedAt: DateTime.now(),
    tags: const ['tag1', 'tag2', 'tag3'],
    updatedAt: DateTime.now(),
    user: PostUser(
      id: '5',
      username: 'User 5',
      avatar: 'https://picsum.photos/200/300',
    ),
    userId: '5',
  ),
];

class MockPostsRepository implements IPostsRepository {
  @override
  Future<List<Post>> getPosts({int? page, int? limit}) async =>
      Future.delayed(const Duration(seconds: 2), () => [...mockPosts]);
}

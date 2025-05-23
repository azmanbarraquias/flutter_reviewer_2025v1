import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_reviewer_2025v1/projects/shop_app/helper/custom_route.dart';
import 'package:flutter_reviewer_2025v1/projects/shop_app/provider/auth.dart';
import 'package:flutter_reviewer_2025v1/projects/shop_app/screens/products_overview_screen.dart';
import 'package:flutter_reviewer_2025v1/utils/xprint.dart';
import 'package:provider/provider.dart';
import 'package:flutter_reviewer_2025v1/projects/shop_app/models/http_exception.dart';

enum AuthMode { signup, login }

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';

  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final transformConfig = Matrix4.rotationZ(-8 * pi / 180);
    transformConfig.translate(-10.0);
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color.fromRGBO(215, 117, 255, 1).withOpacity(0.5),
                  const Color.fromRGBO(255, 188, 117, 1).withOpacity(0.9),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: const [0, 1],
              ),
            ),
          ),
          SingleChildScrollView(
            child: SizedBox(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 20.0),
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 94.0,
                      ),
                      transform: transformConfig,
                      // ..translate(-10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 8,
                            color: Colors.black26,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        'MyShop',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 30,
                          fontFamily: 'Anton',
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: deviceSize.width > 600 ? 2 : 1,
                    child: const AuthCard(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  const AuthCard({super.key});

  @override
  State<AuthCard> createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Size> _heightAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _heightAnimation = Tween<Size>(
      begin: const Size(double.infinity, 260),
      end: const Size(double.infinity, 320),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.fastOutSlowIn,
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1.5),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.fastOutSlowIn,
      ),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  final GlobalKey<FormState> _formKey = GlobalKey();

  AuthMode _authMode = AuthMode.login;
  final Map<String, String> _authData = {'email': '', 'password': ''};

  var _isLoading = false;
  final _passwordController = TextEditingController();

  Future<void> _submit(ctx) async {
    // Navigator.of(context).pushNamed(ProductsOverviewScreen.routeName);

    // Navigator.of(context)
    //     .push(CustomRoute(builder: (ctx) => const ProductsOverviewScreen()));

    // return xPrint('_submit');
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      xPrint('_submit Invalid');
      return;
    }
    xPrint('_submit valid');
    _formKey.currentState?.save();
    setState(() {
      _isLoading = true;
    });
    try {
      if (_authMode == AuthMode.login) {
        // Log user in
        await Provider.of<Auth>(context, listen: false)
            .signIn(
              email: _authData['email']!,
              password: _authData['password']!,
              ctx: ctx,
            )
            .then((_) {
              Navigator.of(ctx).pushNamed(ProductsOverviewScreen.routeName);
            })
            .catchError((error) {
              xPrint(error);
            });
      } else {
        // Sign user up
        await Provider.of<Auth>(context, listen: false)
            .signUp(
              email: _authData['email']!,
              password: _authData['password']!,
              ctx: ctx,
            )
            .then((_) {
              Navigator.of(ctx).pushNamed(ProductsOverviewScreen.routeName);
            })
            .catchError((error) {
              xPrint(error);
            });
      }
    } on HttpException catch (error) {
      xPrint(error);
      _showErrorDialog(error.toString());
    } catch (error) {
      _showErrorDialog(error.toString());
      xPrint(error);
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.login) {
      setState(() {
        _authMode = AuthMode.signup;
      });
      _animationController.forward();
    } else {
      setState(() {
        _authMode = AuthMode.login;
      });
      _animationController.reverse();
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('An Error Occurred'),
          content: Text(message),
          actions: [
            OutlinedButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 8.0,
      child: authPage(deviceSize),
    );
  }

  authPage(Size deviceSize) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
      height: _authMode == AuthMode.signup ? 320 : 260,
      child: Container(
        height: _heightAnimation.value.height,
        // height: _authMode  == AuthMode.signup ? 320 : 260,
        constraints: BoxConstraints(minHeight: _heightAnimation.value.height),
        // BoxConstraints(minHeight: _authMode == AuthMode.signup ? 320 : 260),
        width: deviceSize.width * 0.85,
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(labelText: 'E-Mail'),
                  keyboardType: TextInputType.emailAddress,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'Invalid email!';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _authData['email'] = value!;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  controller: _passwordController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty || value.length < 5) {
                      return 'Password is too short!';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _authData['password'] = value!;
                  },
                ),
                AnimatedContainer(
                  constraints: BoxConstraints(
                    minHeight: _authMode == AuthMode.signup ? 60 : 0,
                    maxHeight: _authMode == AuthMode.signup ? 120 : 0,
                  ),
                  duration: const Duration(milliseconds: 300),
                  child: FadeTransition(
                    opacity: _opacityAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: TextFormField(
                        enabled: _authMode == AuthMode.signup,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: const InputDecoration(
                          labelText: 'Confirm Password',
                        ),
                        obscureText: true,
                        validator:
                            _authMode == AuthMode.signup
                                ? (value) {
                                  if (value != _passwordController.text) {
                                    return 'Passwords do not match!';
                                  }
                                  return null;
                                }
                                : null,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                if (_isLoading)
                  const CircularProgressIndicator()
                else
                  ElevatedButton(
                    onPressed: () => _submit(context),
                    child: Text(
                      _authMode == AuthMode.login ? 'LOGIN' : 'SIGN UP',
                    ),
                  ),
                SizedBox(height: 15),
                TextButton(
                  onPressed: _switchAuthMode,
                  child: Text(
                    '${_authMode == AuthMode.login ? 'SIGNUP' : 'LOGIN'} INSTEAD',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  authPage1(Size deviceSize) {
    return AnimatedBuilder(
      animation: _heightAnimation,
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: 'E-Mail'),
                keyboardType: TextInputType.emailAddress,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value!.isEmpty || !value.contains('@')) {
                    return 'Invalid email!';
                  }
                  return null;
                },
                onSaved: (value) {
                  _authData['email'] = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                controller: _passwordController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value!.isEmpty || value.length < 5) {
                    return 'Password is too short!';
                  }
                  return null;
                },
                onSaved: (value) {
                  _authData['password'] = value!;
                },
              ),
              if (_authMode == AuthMode.signup)
                TextFormField(
                  enabled: _authMode == AuthMode.signup,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                    labelText: 'Confirm Password',
                  ),
                  obscureText: true,
                  validator:
                      _authMode == AuthMode.signup
                          ? (value) {
                            if (value != _passwordController.text) {
                              return 'Passwords do not match!';
                            }
                            return null;
                          }
                          : null,
                ),
              const SizedBox(height: 20),
              if (_isLoading)
                const CircularProgressIndicator()
              else
                ElevatedButton(
                  onPressed: () => _submit(context),
                  child: Text(
                    _authMode == AuthMode.login ? 'LOGIN' : 'SIGN UP',
                  ),
                ),
              TextButton(
                onPressed: _switchAuthMode,
                child: Text(
                  '${_authMode == AuthMode.login ? 'SIGNUP' : 'LOGIN'} INSTEAD',
                ),
              ),
            ],
          ),
        ),
      ),
      builder: (ctx, child) {
        return Container(
          height: _heightAnimation.value.height,
          // height: _authMode == AuthMode.signup ? 320 : 260,
          constraints: BoxConstraints(minHeight: _heightAnimation.value.height),
          // BoxConstraints(minHeight: _authMode == AuthMode.signup ? 320 : 260),
          width: deviceSize.width * 0.85,
          padding: const EdgeInsets.all(16.0),
          child: child,
        );
      },
    );
  }
}

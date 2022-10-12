import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/common/util/huo_log.dart';

/// usage
/// class MyComponent extends Component<T> with PrivateReducerMixin<T> {
///   MyComponent():super(
///     ///
///   );
/// }
///

Reducer<T> asPrivateReducer<T>(Map<Object, Reducer<T>> map) =>
    (map == null || map.isEmpty)
        ? null
        : (T state, Action action) {
            if (action is ComplexSafeAction) {
              if (action.target != state) {
                HuoLog.d("拦截数据错误222${state} ${action.target}");
                return state;
              }
            }
            return map.entries
                    .firstWhere(
                        (MapEntry<Object, Reducer<T>> entry) =>
                            action.type == entry.key,
                        orElse: () => null)
                    ?.value(state, action) ??
                state;
          };

const Object _SUB_EFFECT_RETURN_NULL = Object();

Effect<T> privateCombineEffects<T>(Map<Object, SubEffect<T>> map) =>
    (map == null || map.isEmpty)
        ? null
        : (Action action, Context<T> ctx) {
            if (action is ComplexSafeAction) {
              if (action.target!= ctx.state) {
                HuoLog.d("拦截数据错误111${ctx.state} ${action.target}");
                return null;
              }
            }

            final SubEffect<T> subEffect = map.entries
                .firstWhere(
                  (MapEntry<Object, SubEffect<T>> entry) =>
                      action.type == entry.key,
                  orElse: () => null,
                )
                ?.value;

            if (subEffect != null) {
              return subEffect.call(action, ctx) ?? _SUB_EFFECT_RETURN_NULL;
            }

            //skip-lifecycle-actions
            if (action.type is Lifecycle) {
              return _SUB_EFFECT_RETURN_NULL;
            }

            /// no subEffect
            return null;
          };

mixin ComplexSafeActionMixin<T> on Logic<T> {
//  @override
//  Effect<T> get protectedEffect {
//    final Effect<T> superEffect = super.protectedEffect;
//    return superEffect != null
//        ? (Action action, Context<T> ctx) {
//            if (ctx.state is ComplexSafeState&&action is ComplexSafeAction ) {
//              var state = ctx.state as ComplexSafeState;
//              if (action.target.toString() != state.type) {
//                HuoLog.e("拦截数据错误111${state.type} ${action.target}");
//                return (Action action, Context<T> ctx) {};
//              }
//            }
//
//            return superEffect(action, ctx);
//          }
//        : null;
//  }
//
//  @override
//  Reducer<T> get protectedReducer {
//    final Reducer<T> superReducer = super.protectedReducer;
//    return superReducer != null
//        ? (T state, Action action) {
//            if (state is ComplexSafeState&&action is ComplexSafeAction) {
//              if (action.target.toString() != state.type) {
//                HuoLog.e("拦截数据错误222${state.type} ${action.target}");
//                HuoLog.e("拦截数据错误223 ${action.type} ${action.payload}");
//                return state;
//              }
//            }
////            return superReducer(state, action);
//          }
//        : null;
//  }

  @override
  Dispatch createDispatch(Dispatch effect, Dispatch next, Context<T> ctx) {
    final Dispatch superDispatch = super.createDispatch(effect, next, ctx);
    return (Action action) {
      if (action is! ComplexSafeAction) {
        action = ComplexSafeAction(
          action.type,
          payload: action.payload,
          target: ctx.state,
        );
      }
      return superDispatch(action);
    };
  }
}

class ComplexSafeAction extends Action {
  Object target;

  ComplexSafeAction(Object type, {dynamic payload, this.target})
      : super(type, payload: payload);

  Action asAction() => Action(type, payload: payload);
}

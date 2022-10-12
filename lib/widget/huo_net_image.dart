import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class HuoNetImage extends CachedNetworkImage {
  static PlaceholderWidgetBuilder defaultPlaceholder =
      (context, url) => ConstrainedBox(
            child: Image.asset(
              "images/huo_app_default.png",
              fit: BoxFit.cover,
            ),
            constraints: new BoxConstraints.expand(),
          );
  static LoadingErrorWidgetBuilder defaultErrorWidget =
      (context, url, error) => ConstrainedBox(
            child: Image.asset(
              "images/huo_app_default.png",
              fit: BoxFit.cover,
            ),
            constraints: new BoxConstraints.expand(),
          );

  HuoNetImage({
    Key key,
    @required imageUrl,
    ImageWidgetBuilder imageBuilder,
    PlaceholderWidgetBuilder placeholder,
    LoadingErrorWidgetBuilder errorWidget,
    Duration fadeOutDuration: const Duration(milliseconds: 300),
    Cubic fadeOutCurve: Curves.easeOut,
    Duration fadeInDuration: const Duration(milliseconds: 700),
    Cubic fadeInCurve: Curves.easeIn,
    double width,
    double height,
    BoxFit fit,
    Alignment alignment: Alignment.center,
    ImageRepeat repeat: ImageRepeat.noRepeat,
    bool matchTextDirection: false,
    Map<String, String> httpHeaders,
    BaseCacheManager cacheManager,
    bool useOldImageOnUrlChange: false,
    Color color,
    BlendMode colorBlendMode,
  }) : super(
          key: key,
          imageUrl: imageUrl.toString().contains('http')
              ? imageUrl
              : "http:" + imageUrl,
          imageBuilder: imageBuilder,
          placeholder: placeholder ?? defaultPlaceholder,
          errorWidget: errorWidget ?? defaultErrorWidget,
          fadeOutDuration: fadeOutDuration,
          fadeOutCurve: fadeOutCurve,
          fadeInDuration: fadeInDuration,
          fadeInCurve: fadeInCurve,
          width: width,
          height: height,
          fit: fit,
          alignment: alignment,
          repeat: repeat,
          matchTextDirection: matchTextDirection,
          httpHeaders: httpHeaders,
          cacheManager: cacheManager,
          useOldImageOnUrlChange: useOldImageOnUrlChange,
          color: color,
          colorBlendMode: colorBlendMode,
        );
}

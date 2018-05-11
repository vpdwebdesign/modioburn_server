#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QDir>
#include <QFile>
#include <QScreen>
#include <cmath>
#include <QSettings>
#include <QIcon>

#include "videoplayer/common/common.h"
#include "dbfuncs.h"
#include "mbproxyquerymodel.h"
#include "mbtimer.h"
#include "phonecodeverifier.h"
#include "rbacusermanager.h"
#include "transactionsmodel.h"
#include "shoppingcart.h"
#include "transactionsquerymodel.h"
//#include "stockitemsproxymodel.h"
#include "stockitemsmodel.h"
#include "stockitemspurchasesmodel.h"
#include "stockitemspurchaseslist.h"
#include "itempricemanager.h"
#include "mbfilemanager.h"

int main(int argc, char *argv[])
{
    QGuiApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

   dbConnect(); // Application-wide connection to database

    QQmlApplicationEngine engine;

    // For ModioBurn Audio Player
     QIcon::setThemeName("audioplayer");

    // For ModioBurn Video Player
    QOptions options(get_common_options());
    options.add(QLatin1String("VideoPlayer options"))
            ("scale", 1.0, QLatin1String("scale of graphics context. 0: auto"))
            ;
    options.parse(argc, argv);
    Config::setName(QString::fromLatin1("ModioBurn VideoPlayer"));
    do_common_options_before_qapp(options);

    QDir::setCurrent(qApp->applicationDirPath());

    do_common_options(options);
    set_opengl_backend(options.option(QStringLiteral("gl")).value().toString(), app.arguments().first());
    load_qm(QStringList() << QStringLiteral("ModioBurn VideoPlayer"), options.value(QStringLiteral("language")).toString());

    QString binDir = qApp->applicationDirPath();

    if (!engine.importPathList().contains(binDir))
        engine.addImportPath(binDir);

    QScreen *sc = app.primaryScreen();
    qreal r = sc->physicalDotsPerInch() / sc->logicalDotsPerInch();
    const qreal kR = 1.0;

    if (std::isinf(r) || std::isnan(r))
        r = kR;

    float sr = options.value(QStringLiteral("scale")).toFloat();

    if (qFuzzyIsNull(sr))
        sr = r;

    QObject::connect(&Config::instance(), SIGNAL(changed()), &Config::instance(), SLOT(save()));
    // End: For ModioBurn Video Player


    // Register types here
    qmlRegisterType<MbTimer>("ModioBurn.Tools", 1, 0, "MbTimer");
    qmlRegisterType<PhoneCodeVerifier>("ModioBurn.Tools", 1, 0, "PhoneCodeVerifier");
    qmlRegisterType<RBACUserManager>("ModioBurn.Tools", 1, 0, "UserManager");
    qmlRegisterType<MbProxyQueryModel>("ModioBurn.Tools", 1, 0, "ParentModel");
    qmlRegisterType<TransactionsModel>("ModioBurn.Tools", 1, 0, "TransactionsModel");
    qmlRegisterType<StockItemsPurchasesModel>("ModioBurn.Tools", 1, 0, "StockItemsPurchasesModel");
    qmlRegisterUncreatableType<Session>("ModioBurn.Tools", 1, 0, "Session",
                                             QStringLiteral("Session should not be created in QML"));
    qmlRegisterUncreatableType<ShoppingCart>("ModioBurn.Tools", 1, 0, "ShoppingCart",
                                             QStringLiteral("ShoppingCart should not be created in QML"));
    qmlRegisterUncreatableType<ItemPriceManager>("ModioBurn.Tools", 1, 0, "ItemPriceManager",
                                             QStringLiteral("ItemPriceManager should not be created in QML"));
    qmlRegisterUncreatableType<MbFileManager>("ModioBurn.Tools", 1, 0, "MbFileManager",
                                             QStringLiteral("MbFileManager should not be created in QML"));
    qmlRegisterUncreatableType<TransactionsQueryModel>("ModioBurn.Tools", 1, 0, "TransactionsQueryModel",
                                             QStringLiteral("TransactionsQueryModel should not be created in QML"));
    qmlRegisterUncreatableType<StockItemsPurchasesList>("ModioBurn.Tools", 1, 0, "StockItemsPurchasesList",
                                             QStringLiteral("StockItemsPurchasesList should not be created in QML"));
    qmlRegisterUncreatableType<StockItemsModel>("ModioBurn.Tools", 1, 0, "StockItemsModel",
                                             QStringLiteral("StockItemsModel should not be created in QML"));


    // Add context properties here
    engine.rootContext()->setContextProperty(QStringLiteral("PlayerConfig"), &Config::instance());
    engine.rootContext()->setContextProperty(QStringLiteral("screenPixelDensity"), sc->physicalDotsPerInch()*sc->devicePixelRatio());
    engine.rootContext()->setContextProperty(QStringLiteral("scaleRatio"), sr);

    ShoppingCart shoppingCart;
    ItemPriceManager itemPriceManager;
    MbFileManager fileManager;
    TransactionsQueryModel transactionsQueryModel;
    StockItemsModel stockItemsModel;
    StockItemsPurchasesList stockItemsPurchasesList;

    engine.rootContext()->setContextProperty("shoppingCart", &shoppingCart);
    engine.rootContext()->setContextProperty("itemPriceManager", &itemPriceManager);
    engine.rootContext()->setContextProperty("fileManager", &fileManager);
    engine.rootContext()->setContextProperty("transactionsQueryModel", &transactionsQueryModel);
    engine.rootContext()->setContextProperty("stockItemsModel", &stockItemsModel);
    engine.rootContext()->setContextProperty("stockItemsPurchasesList", &stockItemsPurchasesList);

    engine.load(QUrl(QLatin1String("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}

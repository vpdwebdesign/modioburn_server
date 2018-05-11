#ifndef STOCKITEMSPURCHASESLIST_H
#define STOCKITEMSPURCHASESLIST_H

#include <QObject>
#include <QVector>

#include "stockitem.h"

class StockItemsModel;
class Session;

class StockItemsPurchasesList : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString paymentMethod READ paymentMethod WRITE setPaymentMethod NOTIFY paymentMethodChanged)
    Q_PROPERTY(Session *session READ session WRITE setSession NOTIFY sessionChanged())
    Q_PROPERTY(StockItemsModel *stockItemsModel READ stockItemsModel WRITE setStockItemsModel NOTIFY stockItemsModelChanged())

public:
    explicit StockItemsPurchasesList(QObject *parent = nullptr);

    QString paymentMethod() const;
    void setPaymentMethod(const QString &paymentMethod);

    StockItemsModel *stockItemsModel() const;
    void setStockItemsModel(StockItemsModel *stockItemsModel);

    Session *session() const;
    void setSession(Session *session);

    QVector<StockItem> items() const;

    bool setItemAt(int index, const StockItem &item);

    int itemCount() const;
    Q_INVOKABLE void addNewItem(const QVariantList &newItem);
    Q_INVOKABLE void appendItem(const StockItem &item);
    Q_INVOKABLE bool removeItemAt(int index);
    Q_INVOKABLE double getTotalCostAt(int index) const;
    Q_INVOKABLE void clearList();

    Q_INVOKABLE bool checkoutItems();

signals:
    void paymentMethodChanged();
    void stockItemsModelChanged();
    void sessionChanged(); // Dummy signal to avoid warning about a missing notify signal

    void preItemAppended();
    void postItemAppended();

    void preItemRemoved(int index);
    void postItemRemoved();

    void preListCleared();
    void postListCleared();

    void itemCountChanged(const int itemCount);

    void itemsCheckedout();

private:
    QString m_paymentMethod;
    QVector<StockItem> m_items;

    StockItemsModel *m_stockItemsModel;

    Session *m_session; // We need a pointer to a session object so that we can get the username of the currently logged in
                        // attendant to add to the sales object

};

#endif // STOCKITEMSPURCHASESLIST_H

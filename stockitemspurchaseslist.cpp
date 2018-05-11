#include <QSqlQuery>
#include <QSqlError>
#include <QVariantList>
#include <QDebug>

#include "stockitemspurchaseslist.h"
#include "stockitemsmodel.h"
#include "session.h"

StockItemsPurchasesList::StockItemsPurchasesList(QObject *parent)
    : QObject(parent)
{
    m_session = new Session(this);
    m_stockItemsModel = new StockItemsModel(this);

    connect(this, &StockItemsPurchasesList::itemsCheckedout, this, [=]() {
        m_stockItemsModel->reload();
    });
}

QString StockItemsPurchasesList::paymentMethod() const
{
    return m_paymentMethod;
}

void StockItemsPurchasesList::setPaymentMethod(const QString &paymentMethod)
{
    if (paymentMethod != m_paymentMethod)
    {
        m_paymentMethod = paymentMethod;
        emit paymentMethodChanged();
    }
}

StockItemsModel *StockItemsPurchasesList::stockItemsModel() const
{
    return m_stockItemsModel;
}

void StockItemsPurchasesList::setStockItemsModel(StockItemsModel *stockItemsModel)
{
    if (stockItemsModel != m_stockItemsModel)
    {
        m_stockItemsModel = stockItemsModel;
        emit stockItemsModelChanged();
    }
}


Session *StockItemsPurchasesList::session() const
{
    return m_session;
}

void StockItemsPurchasesList::setSession(Session *session)
{
    if (session != m_session)
    {
        m_session = session;
        emit sessionChanged();
    }
}

QVector<StockItem> StockItemsPurchasesList::items() const
{
    return m_items;
}

bool StockItemsPurchasesList::setItemAt(int index, const StockItem &item)
{
    if (index < 0 || index >= m_items.size())
        return false;

    const StockItem &oldItem = m_items.at(index);

    if (item.itemName == oldItem.itemName &&
        item.itemSize == oldItem.itemSize &&
        item.quantity == oldItem.quantity &&
        item.pricePerUnit == oldItem.pricePerUnit &&
        item.totalCost == oldItem.totalCost)
    {
        return false;
    }

    m_items[index] = item;
    emit itemCountChanged(itemCount());
    return true;
}

int StockItemsPurchasesList::itemCount() const
{
    return m_items.size();
}

void StockItemsPurchasesList::addNewItem(const QVariantList &newItem)
{
    StockItem item;
    item.itemName = newItem.at(0).toString();
    item.itemSize = newItem.at(1).toString();
    item.quantity = newItem.at(2).toInt();
    item.pricePerUnit = newItem.at(3).toDouble();
    item.totalCost = newItem.at(4).toDouble();

    appendItem(item);

}

void StockItemsPurchasesList::appendItem(const StockItem &item)
{
    emit preItemAppended();

    m_items.append(item);
    emit itemCountChanged(itemCount());

    emit postItemAppended();
}

bool StockItemsPurchasesList::removeItemAt(int index)
{
    if (index < 0 || index >= m_items.size())
        return false;

    emit preItemRemoved(index);

    m_items.removeAt(index);
    emit itemCountChanged(itemCount());

    emit postItemRemoved();

    return true;
}

double StockItemsPurchasesList::getTotalCostAt(int index) const
{
    if (index < 0 || index >= m_items.size())
        return 0;

    return m_items.at(index).totalCost;
}

void StockItemsPurchasesList::clearList()
{
    if (m_items.size() > 0)
    {
        emit preListCleared();

        m_items.clear();
        emit itemCountChanged(itemCount());

        emit postListCleared();
    }
}

bool StockItemsPurchasesList::checkoutItems()
{
    QSqlQuery query;

    // loop through container of items, UPDATING quantity field of stock_items table
    QString itemName = QString();
    QString itemSize = QString();
    int quantity = 0;
    int successfulQueryCounter = 0;

    QVector<StockItem>::const_iterator i;
    for (i = m_items.begin(); i != m_items.end(); ++i)
    {
        itemName = (*i).itemName;
        itemSize = (*i).itemSize;
        quantity = (*i).quantity;

        // Decrease quantity
        query.prepare("UPDATE stock_items SET quantity = (quantity - :quantity) "
                      "WHERE name = :itemName AND size = :itemSize");
        query.bindValue(":itemName", itemName);
        query.bindValue(":itemSize", itemSize);
        query.bindValue(":quantity", quantity);

        if (query.exec())
        {
            ++successfulQueryCounter;
            qDebug() << "Quantity field updated successfuly for item:" << itemName << "-" << itemSize;
        }
        else
        {
            qDebug() << "Error:" << query.lastError().text();
        }
    }

    query.finish();

    // loop again through container of items, adding data to db
    itemName = QString();
    itemSize = QString();
    quantity = 0;
    double pricePerUnit = 0.00;
    double totalCost = 0.00;
    successfulQueryCounter = 0;

    QVector<StockItem>::const_iterator j;
    for (j = m_items.begin(); j != m_items.end(); ++j)
    {
        itemName = (*j).itemName;
        itemSize = (*j).itemSize;
        quantity = (*j).quantity;
        pricePerUnit = (*j).pricePerUnit;
        totalCost = (*j).totalCost;

        // Decrease quantity

        query.prepare("INSERT INTO stock_items_sales (item_name, item_size, quantity, "
                      "price_per_unit, total_cost, payment_method, sold_by, sold_on) "
                      "VALUES (:item_name, :item_size, :quantity, :price_per_unit, "
                      ":total_cost, :payment_method, :username, localtimestamp)");
        query.bindValue(":item_name", itemName);
        query.bindValue(":item_size", itemSize);
        query.bindValue(":quantity", quantity);
        query.bindValue(":price_per_unit", pricePerUnit);
        query.bindValue(":total_cost", totalCost);
        query.bindValue(":payment_method", m_paymentMethod);
        query.bindValue(":username", m_session->username()); // the Session object's username() getter function is guaranteed to return
                                                             // a username since the StockItemsPurchasesList object cannot be instantiated before
                                                             // a user logs in

        if (query.exec())
        {
            ++successfulQueryCounter;
            qDebug() << "Insert stock items purchases query successful.";
        }
        else
        {
            qDebug() << "Error:" << query.lastError().text();
        }
    }

    if (successfulQueryCounter == m_items.size())
    {
        qDebug() << "All purchases successfully checked out.";
        clearList(); // Safe to clear list of items
        emit itemsCheckedout();

        return true;
    }
    else {
        qDebug() << "Some or all purchases were not checked out.";
        return false;
    }

    return false;
}

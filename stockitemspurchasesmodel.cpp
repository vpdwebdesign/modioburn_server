#include <QDebug>

#include "stockitemspurchasesmodel.h"
#include "stockitemspurchaseslist.h"

StockItemsPurchasesModel::StockItemsPurchasesModel(QObject *parent)
    : QAbstractListModel(parent),
      m_list(nullptr),
      m_listItemCount(0)
{
}

int StockItemsPurchasesModel::rowCount(const QModelIndex &parent) const
{
    // For list models only the root node (an invalid parent) should return the list's size. For all
    // other (valid) parents, rowCount() should return 0 so that it does not become a tree model.
    if (parent.isValid() || !m_list)
        return 0;

    return m_list->items().size();
}

QVariant StockItemsPurchasesModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || !m_list)
        return QVariant();

    const StockItem &item = m_list->items().at(index.row());

    switch (role) {
    case itemNameRole:
        return item.itemName;
        break;
    case itemSizeRole:
        return item.itemSize;
        break;
    case quantityRole:
        return item.quantity;
        break;
    case pricePerUnitRole:
        return item.pricePerUnit;
        break;
    case totalCostRole:
        return item.totalCost;
        break;
    }

    return QVariant();
}

bool StockItemsPurchasesModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if (!m_list)
        return false;

    StockItem item = m_list->items().at(index.row());

    switch (role) {
    case itemNameRole:
        item.itemName = value.toString();
        break;
    case itemSizeRole:
        item.itemSize = value.toString();
        break;
    case quantityRole:
        item.quantity = value.toInt();
        break;
    case pricePerUnitRole:
        item.pricePerUnit = value.toDouble();
        break;
    case totalCostRole:
        item.totalCost = value.toDouble();
        break;
    }

    if (m_list->setItemAt(index.row(), item)) {
        emit dataChanged(index, index, QVector<int>() << role);
        return true;
    }
    return false;
}

Qt::ItemFlags StockItemsPurchasesModel::flags(const QModelIndex &index) const
{
    if (!index.isValid())
        return Qt::NoItemFlags;

    return Qt::ItemIsEditable;
}

QHash<int, QByteArray> StockItemsPurchasesModel::roleNames() const
{
    QHash<int, QByteArray> rNames;
    rNames[itemNameRole] = "itemName";
    rNames[itemSizeRole] = "itemSize";
    rNames[quantityRole] = "quantity";
    rNames[pricePerUnitRole] = "pricePerUnit";
    rNames[totalCostRole] = "totalCost";

    return rNames;
}

StockItemsPurchasesList *StockItemsPurchasesModel::list() const
{
    return m_list;
}

void StockItemsPurchasesModel::setList(StockItemsPurchasesList *list)
{
    beginResetModel();

    if (m_list)
        disconnect(this);

    m_list = list;

    if (m_list)
    {
        connect(m_list, &StockItemsPurchasesList::preItemAppended, this, [=]() {
            const int index = m_list->items().size();
            beginInsertRows(QModelIndex(), index, index);
        });
        connect(m_list, &StockItemsPurchasesList::postItemAppended, this, [=]() {
            endInsertRows();
        });

        connect(m_list, &StockItemsPurchasesList::preItemRemoved, this, [=](int index) {
            beginRemoveRows(QModelIndex(), index, index);
        });
        connect(m_list, &StockItemsPurchasesList::postItemRemoved, this, [=]() {
            endRemoveRows();
        });

        connect(m_list, &StockItemsPurchasesList::preListCleared, this, [=]() {
            beginResetModel();
        });
        connect(m_list, &StockItemsPurchasesList::postListCleared, this, [=]() {
            endResetModel();
        });

        connect(m_list, &StockItemsPurchasesList::itemCountChanged, this, [=](int count) {
            m_listItemCount = m_list->itemCount();
            qDebug () << "itemCountChanged() signal:" << count;
            emit listItemCountChanged(count);
        });

    }

    endResetModel();
}

int StockItemsPurchasesModel::listItemCount() const
{
    return m_listItemCount;
}

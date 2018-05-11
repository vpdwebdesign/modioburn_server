#include <QSqlRecord>
#include <QSqlQuery>
#include <QSqlError>
#include <QDebug>

#include "stockitemsmodel.h"

StockItemsModel::StockItemsModel(QObject *parent)
    : QSqlTableModel(parent)
{
    setTable("stock_items");
    setEditStrategy(QSqlTableModel::OnFieldChange);
    sort(1, Qt::AscendingOrder);
}

QVariant StockItemsModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    QVariant value;

     if (index.isValid()) {
        if (role < Qt::UserRole) {
            value = QSqlTableModel::data(index, role);
        } else {
            int columnIdx = role - Qt::UserRole;
            QModelIndex modelIndex = this->index(index.row(), columnIdx);
            value = QSqlTableModel::data(modelIndex, Qt::DisplayRole);
        }
        return value;
    }

    return QVariant();
}

bool StockItemsModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    Q_UNUSED(role)

    if (index.column() != 6)
        return false;

    bool setDataOk = false;

    setDataOk = setQuantity(index.row(), value.toInt());

    if (setDataOk) {
        emit dataChanged(index, index);
        return true;
    }

    return false;
}

Qt::ItemFlags StockItemsModel::flags(const QModelIndex &index) const
{
    if (!index.isValid())
        return Qt::NoItemFlags;

    Qt::ItemFlags flags = QSqlTableModel::flags(index);
          if (index.column() == 6)
              flags |= Qt::ItemIsEditable;
          return flags;
}

QHash<int, QByteArray> StockItemsModel::roleNames() const
{
    QHash<int, QByteArray> rNames;

    for (int i = 0; i < record().count(); ++i)
    {
        rNames.insert(Qt::UserRole + i, record().fieldName(i).toUtf8());
    }

    return rNames;
}

void StockItemsModel::reload()
{
    select();
}

bool StockItemsModel::setQuantity(int rowIndex, int quantity)
{
    QModelIndex primaryKey = QSqlTableModel::index(rowIndex, 0);
    int id = data(primaryKey).toInt();

    QSqlQuery query;
    query.prepare("UPDATE stock_items SET quantity = :quantity WHERE id = :id");
    query.bindValue(":quantity", quantity);
    query.bindValue(":id", id);

    if (query.exec())
    {
        qDebug() << "Stock item quantity for item with ID" << id << "updated successfully";
        return true;
    }
    else
    {
        qDebug() << "Update failed for quantity of stock item with ID" << id;
        return false;
    }

    return false;

}

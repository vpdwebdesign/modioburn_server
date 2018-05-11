#include "transactionsquerymodel.h"
#include <QSqlRecord>
#include <QSqlQuery>
#include <QSqlError>
#include <QDateTime>
#include <QDebug>

TransactionsQueryModel::TransactionsQueryModel(QObject *parent)
    : QSqlTableModel(parent)
{
    setTable("transactions");
    setEditStrategy(QSqlTableModel::OnFieldChange);
    reload();
}

QVariant TransactionsQueryModel::data(const QModelIndex &index, int role) const
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

bool TransactionsQueryModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    Q_UNUSED(role)

    if (index.column() != 9 || index.column() != 12 || index.column() != 13)
        return false;

    bool setDataOk = false;

    switch (index.column()) {
    case 9:
        setDataOk = setStatus(index.row(), value.toString());
        break;
    case 12:
        setDataOk = setCancelledAt(index.row());
        break;
    case 13:
        setDataOk = setCompletedAt(index.row());
        break;
    }

    if (setDataOk) {
        emit dataChanged(index, index);
        return true;
    }
    return false;
}

Qt::ItemFlags TransactionsQueryModel::flags(const QModelIndex &index) const
{
    if (!index.isValid())
        return Qt::NoItemFlags;

    Qt::ItemFlags flags = QSqlTableModel::flags(index);
          if (index.column() == 9 || index.column() == 12 || index.column() == 13)
              flags |= Qt::ItemIsEditable;
          return flags;
}

QHash<int, QByteArray> TransactionsQueryModel::roleNames() const
{
    QHash<int, QByteArray> rNames;

    for (int i = 0; i < record().count(); ++i)
    {
        rNames.insert(Qt::UserRole + i, record().fieldName(i).toUtf8());
    }

    return rNames;
}

void TransactionsQueryModel::filterData(const QString& filter)
{
    setFilter(QString("status='%1'").arg(filter));
    reload();
}

void TransactionsQueryModel::searchData(const QString& filter, const QString& status)
{
    QSqlQuery query(QString("SELECT * FROM transactions WHERE (lower(item_type)=%1 "
                    "OR lower(username)=%1 "
                    "OR lower(copy_medium)=%1 "
                    "OR lower(payment_method)=%1) AND lower(status)=%2").arg(filter).arg(status));
    setQuery(query);
}

void TransactionsQueryModel::sortData(int col, const Qt::SortOrder& sortOrder)
{
    if (col < 0 || col >= columnCount())
        return;

    setSort(col, sortOrder);
    reload();
}

void TransactionsQueryModel::reload()
{
    select();
}

bool TransactionsQueryModel::setStatus(int id, const QString& status)
{
    QSqlQuery query;
    query.prepare("UPDATE transactions SET status = :status WHERE id = :id");
    query.bindValue(":status", status);
    query.bindValue(":id", id);

    if (query.exec())
    {
        qDebug() << "Transaction status updated successfully";
        return true;
    }
    else
    {
        qDebug() << "Transaction status update failed:" << query.lastError();
        return false;
    }

    return false;
}

bool TransactionsQueryModel::setCancelledAt(int rowIndex)
{
    QModelIndex primaryKey = QSqlTableModel::index(rowIndex, 0);
    int id = data(primaryKey).toInt();

    if (setStatus(id, "cancelled"))
    {
        QSqlQuery query;
        query.prepare("UPDATE transactions SET cancelled_at = localtimestamp WHERE id = :id");
        query.bindValue(":id", id);

        if (query.exec())
        {
            reload();
            qDebug() << "Transaction cancelled timestamp updated successfully";
            return true;
        }
        else
        {
            qDebug() << "Transaction cancelled timestamp update failed:" << query.lastError();
            return false;
        }
    }
    else
    {
        qDebug() << "Failed to update transaction status to cancelled.";
        return false;
    }

    return false;

}

bool TransactionsQueryModel::setCompletedAt(int rowIndex)
{
    QModelIndex primaryKey = QSqlTableModel::index(rowIndex, 0);
    int id = data(primaryKey).toInt();

    if (setStatus(id, "completed"))
    {
        QSqlQuery query;
        query.prepare("UPDATE transactions SET completed_at = localtimestamp WHERE id = :id");
        query.bindValue(":id", id);

        if (query.exec())
        {
            reload();
            qDebug() << "Transaction completed timestamp updated successfully";
            return true;
        }
        else
        {
            qDebug() << "Transaction completed timestamp update failed:" << query.lastError();
            return false;
        }
    }
    else
    {
        qDebug() << "Failed to update transaction status to completed.";
        return false;
    }

    return false;

}

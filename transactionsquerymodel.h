#ifndef TRANSACTIONSQUERYMODEL_H
#define TRANSACTIONSQUERYMODEL_H

#include <QSqlTableModel>

class QDateTime;

class TransactionsQueryModel : public QSqlTableModel
{
    Q_OBJECT

public:
    explicit TransactionsQueryModel(QObject *parent = nullptr);

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    // Editable:
    bool setData(const QModelIndex &index, const QVariant &value,
                 int role = Qt::EditRole) override;

    Qt::ItemFlags flags(const QModelIndex& index) const override;

    virtual QHash<int, QByteArray> roleNames() const override;

    void reload();
    Q_INVOKABLE void filterData(const QString& filter);
    Q_INVOKABLE void searchData(const QString& filter, const QString& status);
    Q_INVOKABLE void sortData(int col, const Qt::SortOrder& sortOrder);
    Q_INVOKABLE bool setStatus(int id, const QString& status);
    Q_INVOKABLE bool setCancelledAt(int rowIndex);
    Q_INVOKABLE bool setCompletedAt(int rowIndex);
};

#endif // TRANSACTIONSQUERYMODEL_H

#ifndef PERSONNELMANAGEMENTMODEL_H
#define PERSONNELMANAGEMENTMODEL_H

#include <QSqlTableModel>

class PersonnelManagementModel : public QSqlTableModel
{
    Q_OBJECT

public:
    explicit PersonnelManagementModel(QObject *parent = nullptr);

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    // Editable:
    bool setData(const QModelIndex &index, const QVariant &value,
                 int role = Qt::EditRole) override;

    Qt::ItemFlags flags(const QModelIndex& index) const override;

};

#endif // PERSONNELMANAGEMENTMODEL_H

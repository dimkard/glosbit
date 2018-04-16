/*
 * Copyright (C) 2018 Dimitris Kardarakos
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation; either version 3 of
 * the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this library.  If not, see <http://www.gnu.org/licenses/>.
 *
 */

#ifndef GLOSBITCONFIG_G
#define GLOSBITCONFIG_G

#include <QObject>

class GlosbitConfig : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString recentSource READ recentSource WRITE setRecentSource NOTIFY recentSourceChanged)
    Q_PROPERTY(QString recentTarget READ recentTarget WRITE setRecentTarget NOTIFY recentTargetChanged)

public:

    explicit GlosbitConfig(QObject* parent = nullptr);
    ~GlosbitConfig() override;

    QString recentSource() const;
    Q_INVOKABLE void setRecentSource(const QString& dictionaryIndex);
    Q_SIGNAL void recentSourceChanged();

    QString recentTarget() const;
    Q_INVOKABLE void setRecentTarget(const QString& dictionaryIndex);
    Q_SIGNAL void recentTargetChanged();
    

private:
    class Private;
    Private* d;
};

#endif//GLOSBITCONFIG_G
